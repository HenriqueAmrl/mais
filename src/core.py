from google.cloud import bigquery, storage
from google.oauth2 import service_account
import yaml
from jinja2 import Template
from pathlib import Path, PosixPath
import json
import csv
from enum import Enum
from copy import deepcopy

from google.api_core.exceptions import Conflict
import google.api_core.exceptions
from google.cloud.exceptions import NotFound


class Base:
    def __init__(
        self,
        key_path="secrets/cli-admin.json",
        templates="src/templates",
        bucket_name="basedosdados",
        metadata_path="bases/",
    ):
        self.templates = Path(templates)
        self.metadata_path = Path(metadata_path)
        self.bucket_name = bucket_name

        credentials = service_account.Credentials.from_service_account_file(
            key_path,
            scopes=["https://www.googleapis.com/auth/cloud-platform"],
        )
        self.client = dict(
            bigquery=bigquery.Client(
                credentials=credentials,
                project=credentials.project_id,
            ),
            storage=storage.Client(
                credentials=credentials,
                project=credentials.project_id,
            ),
        )
        self.uri = f"gs://{bucket_name}" + "/staging/{dataset}/{table}/*"

    def load_yaml(self, file):

        try:
            return yaml.load(open(file, "r"), Loader=yaml.SafeLoader)
        except FileNotFoundError:
            return None

    def render_template(self, template_file, kargs):

        return Template((self.templates / template_file).open("r").read()).render(
            **kargs
        )

    def check_mode(self, mode):
        ACCEPTED_MODES = ["all", "staging", "prod"]
        if mode in ACCEPTED_MODES:
            return True
        else:
            raise Exception(
                f"Argument {mode} not supported. "
                f"Enter one of the following: "
                ",".join(ACCEPTED_MODES)
            )


class Dataset(Base):
    def __init__(self, dataset_id, **kwargs):
        super().__init__(**kwargs)

        self.dataset_id = dataset_id.replace("-", "_")
        self.dataset_folder = Path(self.metadata_path / self.dataset_id)

    @property
    def dataset_config(self):

        return self.load_yaml(
            self.metadata_path / self.dataset_id / "dataset_config.yaml"
        )

    def _create_dataset_ids(self, mode="all"):

        dataset_ids = []

        if (mode == "prod") or (mode == "all"):

            dataset_ids.append(
                f"{self.client['bigquery'].project}.{self.dataset_config['dataset_id']}"
            )

        if (mode == "staging") or (mode == "all"):

            dataset_ids.append(
                f"{self.client['bigquery'].project}.{self.dataset_config['dataset_id']}_staging"
            )

        return dataset_ids

    def _setup_dataset_object(self, dataset_id):

        dataset = bigquery.Dataset(dataset_id)
        dataset.description = self.render_template(
            "dataset/dataset_description.txt", self.dataset_config
        )

        return dataset

    def init(self, replace=False):

        # Create dataset folder
        try:
            self.dataset_folder.mkdir(exist_ok=replace, parents=True)
        except FileExistsError:
            raise FileExistsError(
                f"Dataset {str(self.dataset_folder.stem)} folder does not exists. "
                "Set replace=True to replace current files."
            )

        for file in (Path(self.templates) / "dataset").glob("*"):

            if file.name in ["dataset_config.yaml", "README.md"]:

                # Load and fill template
                template = Template(file.open("r").read()).render(
                    dataset_id=self.dataset_id
                )

                # Write file
                (self.dataset_folder / file.name).open("w").write(template)

        # Add code folder
        (self.dataset_folder / "code").mkdir(exist_ok=replace, parents=True)

        return self

    def publicize(self):

        dataset = self.client["bigquery"].get_dataset(self.dataset_id)
        entries = dataset.access_entries

        entries.extend(
            [
                bigquery.AccessEntry(
                    role="roles/bigquery.dataViewer",
                    entity_type="iamMember",
                    entity_id="allUsers",
                ),
                bigquery.AccessEntry(
                    role="roles/bigquery.metadataViewer",
                    entity_type="iamMember",
                    entity_id="allUsers",
                ),
                bigquery.AccessEntry(
                    role="roles/bigquery.user",
                    entity_type="iamMember",
                    entity_id="allUsers",
                ),
            ]
        )
        dataset.access_entries = entries

        self.client["bigquery"].update_dataset(dataset, ["access_entries"])

    def create(self, mode="all", if_exists="raise"):

        if if_exists == "replace":
            self.delete(mode)
        elif if_exists == "update":
            self.update()
            return

        # Set dataset_id to the ID of the dataset to create.
        for ds_id in self._create_dataset_ids(mode):

            # Construct a full Dataset object to send to the API.
            dataset_obj = self._setup_dataset_object(ds_id)

            # Send the dataset to the API for creation, with an explicit timeout.
            # Raises google.api_core.exceptions.Conflict if the Dataset already
            # exists within the project.
            try:
                job = self.client["bigquery"].create_dataset(
                    dataset_obj
                )  # Make an API request.
            except Conflict:

                if if_exists == "pass":
                    return
                else:
                    raise Conflict(f"Dataset {self.dataset_id} already exists")

        # Make prod dataset public
        self.publicize()

    def delete(self, mode="all"):

        for ds_id in self._create_dataset_ids(mode):

            self.client["bigquery"].delete_dataset(
                ds_id, delete_contents=True, not_found_ok=True
            )

    def update(self, mode="all"):

        # Set dataset_id to the ID of the dataset to create.
        dataset_ids = self._create_dataset_ids(mode)

        for ds_id in dataset_ids:

            # Construct a full Dataset object to send to the API.
            dataset = self._setup_dataset_object(ds_id)

            # Send the dataset to the API to update, with an explicit timeout.
            # Raises google.api_core.exceptions.Conflict if the Dataset already
            # exists within the project.
            dataset = self.client["bigquery"].update_dataset(
                dataset, fields=["description"]
            )  # Make an API request.


class Table(Base):
    def __init__(self, table_id, dataset_id, **kwargs):
        super().__init__(**kwargs)

        self.table_id = table_id.replace("-", "_")
        self.dataset_id = dataset_id.replace("-", "_")
        self.dataset_folder = Path(self.metadata_path / self.dataset_id)
        self.table_folder = self.dataset_folder / table_id
        self.table_full_name = dict(
            prod=f"{self.client['bigquery'].project}.{self.dataset_id}.{self.table_id}",
            staging=f"{self.client['bigquery'].project}.{self.dataset_id}_staging.{self.table_id}",
        )
        self.table_full_name.update(dict(all=deepcopy(self.table_full_name)))

    @property
    def table_config(self):
        return self.load_yaml(self.table_folder / "table_config.yaml")

    def get_table_obj(self, mode):
        return self.client["bigquery"].get_table(self.table_full_name[mode])

    def _load_schema(self, mode="staging"):
        """Load schema from table_config.yaml"""

        json_path = self.table_folder / f"schema-{mode}.json"

        columns = self.table_config["columns"]

        if mode == "staging":
            for c in columns:
                c["type"] = "STRING"

            columns = [c for c in columns if c["is_in_staging"]]

        elif mode == "prod":
            schema = self.get_table_obj(mode).schema

            for c in columns:
                for s in schema:
                    if c["name"] == s.name:
                        c["type"] = s.field_type

        json.dump(columns, (json_path).open("w"))

        return self.client["bigquery"].schema_from_json(str(json_path))

    def init(self, data_sample_path=None, replace=False):

        if not self.dataset_folder.exists():
            print(self.dataset_folder)
            raise FileExistsError(
                f"Dataset folder {self.dataset_folder} folder does not exists. "
                "Create a dataset before adding tables."
            )

        try:
            self.table_folder.mkdir(exist_ok=replace)
        except FileExistsError:
            raise FileExistsError(
                f"Table folder already exists for {self.table_id}. "
                "Add --replace flag to replace current files."
            )

        if isinstance(
            data_sample_path,
            (
                str,
                PosixPath,
            ),
        ):
            data_sample_path = Path(data_sample_path)
            if data_sample_path.suffix == ".csv":

                columns = next(csv.reader(open(data_sample_path, "r")))

            else:
                raise NotImplementedError(
                    "Data sample just supports comma separated csv files"
                )
        else:
            columns = ["<column-name>"]

        for file in (Path(self.templates) / "table").glob("*"):

            if file.name in ["table_config.yaml", "publish.sql"]:

                # Load and fill template
                template = Template(file.open("r").read()).render(
                    table_id=self.table_id,
                    dataset_id=self.dataset_folder.stem,
                    project_id=self.client["bigquery"].project,
                    columns=columns,
                )

                # Write file
                (self.table_folder / file.name).open("w").write(template)

        return self

    def create(self, job_config_params=None, partitioned=False, if_exists="raise"):
        """
        Creates table in staging dataset

        TODO: Implement if_exists=raise
        TODO: Implement if_exists=pass
        """

        if job_config_params is None:

            job_config_params = dict(
                write_disposition=bigquery.WriteDisposition.WRITE_TRUNCATE,
                source_format=bigquery.SourceFormat.CSV,
                skip_leading_rows=1,
            )

        if isinstance(job_config_params, dict):

            job_config_params.update(
                dict(
                    schema=self._load_schema(),
                    destination_table_description=self.render_template(
                        "table/table_description.txt", self.table_config
                    ),
                )
            )

        if partitioned:

            hive_partitioning = bigquery.external_config.HivePartitioningOptions()
            hive_partitioning.mode = "AUTO"
            hive_partitioning.source_uri_prefix = self.uri.format(
                dataset=self.dataset_id, table=self.table_id
            ).replace("*", "")

            job_config_params["hive_partitioning"] = hive_partitioning

        job_config = bigquery.LoadJobConfig(**job_config_params)

        if if_exists == "replace":
            self.delete(mode="staging")

        load_job = self.client["bigquery"].load_table_from_uri(
            self.uri.format(
                dataset=self.table_config["dataset_id"],
                table=self.table_config["table_id"],
            ),
            self.table_full_name["staging"],
            job_config=job_config,
        )

        load_job.result()

    def update(self, mode="all", not_found_ok=True):

        # TODO: add support for prod and staging

        if mode == "all":
            mode = ["prod", "staging"]
        else:
            mode = [mode]

        for m in mode:

            try:
                table = self.get_table_obj(m)
            except google.api_core.exceptions.NotFound:
                continue

            table.description = self.render_template(
                "table/table_description.txt", self.table_config
            )
            table.schema = self._load_schema(m)

            self.client["bigquery"].update_table(
                table, fields=["description", "schema"]
            )

    def publish(self, if_exists="raise"):

        # TODO: check if all required fields are filled
        # TODO: Auto add column description

        view = bigquery.Table(self.table_full_name["prod"])

        view.view_query = (self.table_folder / "publish.sql").open("r").read()

        view.description = self.render_template(
            "table/table_description.txt", self.table_config
        )

        if if_exists == "replace":
            self.delete(mode="prod")

        self.client["bigquery"].create_table(view)

        self.update("prod")

    def delete(self, mode):

        if mode == "all":
            for k, n in self.table_full_name[mode].items():
                self.client["bigquery"].delete_table(n, not_found_ok=True)
        else:
            self.client["bigquery"].delete_table(
                self.table_full_name[mode], not_found_ok=True
            )


class Storage(Base):
    def __init__(self, dataset_id=None, table_id=None, **kwargs):

        super().__init__(**kwargs)

        self.bucket = self.client["storage"].bucket(self.bucket_name)
        self.dataset_id = dataset_id.replace("-", "_")
        self.table_id = table_id.replace("-", "_")

    def init(self, replace=False, very_sure=False):
        """Create bucket and folders"""

        if replace:
            if not very_sure:
                raise Warning(
                    "\n********************************************************"
                    "\nYou are trying to replace all the data that you have "
                    f"in bucket {self.bucket_name}.\nAre you sure?\n"
                    "If yes, add the flag --very_sure\n"
                    "********************************************************"
                )
            else:
                self.bucket.delete(force=True)

        self.client["storage"].create_bucket(self.bucket)

        for folder in ["staging/", "raw/"]:

            self.bucket.blob(folder).upload_from_string("")

    def _resolve_partitions(self, partitions):

        if isinstance(partitions, dict):

            return "/".join([f"{k}={v}" for k, v in partitions.items()]) + "/"

        elif isinstance(partitions, str):

            # check if it fits rule
            {b.split("=")[0]: b.split("=")[1] for b in partitions.split("/")}

            return partitions if partitions.endswith("/") else partitions + "/"

        else:

            raise Exception(f"Partitions format or type not accepted: {partitions}")

    def _build_blob_name(self, filename, mode, partitions=None):

        # table folder
        blob_name = f"{mode}/{self.dataset_id}/{self.table_id}/"

        # add partition folder
        if partitions is not None:

            blob_name += self._resolve_partitions(partitions)

        # add file name
        blob_name += filename

        return blob_name

    def upload(self, filepath, mode, partitions=None, if_exists="raise", **upload_args):

        self.check_mode(mode)

        if (self.dataset_id is None) or (self.table_id is None):
            raise Exception("You need to pass dataset_id and table_id")

        blob_name = self._build_blob_name(Path(filepath).name, mode, partitions)

        blob = self.bucket.blob(blob_name)

        if not blob.exists() or if_exists == "replace":

            blob.upload_from_filename(str(filepath), **upload_args)

        else:
            raise Exception(
                f"Data already exists at {blob_name}. "
                "Add flag --if_exists=replace to overwrite data"
            )

        return blob_name

    def delete_file(self, filename, mode, partitions=None, not_found_ok=False):

        blob = self.bucket.blob(self._build_blob_name(filename, mode, partitions))

        if blob.exists():
            blob.delete()
        elif not_found_ok:
            return
        else:
            blob.delete()


if __name__ == "__main__":

    table = Table("test", "test", key_path="as")
    table.publish("replace")
