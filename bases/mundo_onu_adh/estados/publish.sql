/*

Query para publicar a tabela.

Esse é o lugar para:
    - modificar nomes, ordem e tipos de colunas
    - dar join com outras tabelas
    - criar colunas extras (e.g. logs, proporções, etc.)

Qualquer coluna definida aqui deve também existir em `table_config.yaml`.

# Além disso, sinta-se à vontade para alterar alguns nomes obscuros
# para algo um pouco mais explícito.

TIPOS:
    - Para modificar tipos de colunas, basta substituir STRING por outro tipo válido.
    - Exemplo: `SAFE_CAST(column_name AS NUMERIC) column_name`
    - Mais detalhes: https://cloud.google.com/bigquery/docs/reference/standard-sql/data-types

*/
CREATE VIEW `basedosdados.mundo_onu_adh.estados` AS
SELECT
SAFE_CAST(id_uf AS INT64) id_uf,
SAFE_CAST(uf AS STRING) uf,
SAFE_CAST(ano AS INT64) ano,
SAFE_CAST(expectativa_vida AS FLOAT64) expectativa_vida,
SAFE_CAST(fecundidade_total AS FLOAT64) fecundidade_total,
SAFE_CAST(mortalidade_1 AS FLOAT64) mortalidade_1,
SAFE_CAST(mortalidade_5 AS FLOAT64) mortalidade_5,
SAFE_CAST(razao_dependencia AS FLOAT64) razao_dependencia,
SAFE_CAST(prob_sobrevivencia_40 AS FLOAT64) prob_sobrevivencia_40,
SAFE_CAST(prob_sobrevivencia_60 AS FLOAT64) prob_sobrevivencia_60,
SAFE_CAST(taxa_envelhecimento AS FLOAT64) taxa_envelhecimento,
SAFE_CAST(expectativa_anos_estudo AS FLOAT64) expectativa_anos_estudo,
SAFE_CAST(taxa_analfabetismo_11_a_14 AS FLOAT64) taxa_analfabetismo_11_a_14,
SAFE_CAST(taxa_analfabetismo_15_a_17 AS FLOAT64) taxa_analfabetismo_15_a_17,
SAFE_CAST(taxa_analfabetismo_15_mais AS FLOAT64) taxa_analfabetismo_15_mais,
SAFE_CAST(taxa_analfabetismo_18_a_24 AS FLOAT64) taxa_analfabetismo_18_a_24,
SAFE_CAST(taxa_analfabetismo_18_mais AS FLOAT64) taxa_analfabetismo_18_mais,
SAFE_CAST(taxa_analfabetismo_25_a_29 AS FLOAT64) taxa_analfabetismo_25_a_29,
SAFE_CAST(taxa_analfabetismo_25_mais AS FLOAT64) taxa_analfabetismo_25_mais,
SAFE_CAST(taxa_atraso_0_basico AS FLOAT64) taxa_atraso_0_basico,
SAFE_CAST(taxa_atraso_0_fundamental AS FLOAT64) taxa_atraso_0_fundamental,
SAFE_CAST(taxa_atraso_0_medio AS FLOAT64) taxa_atraso_0_medio,
SAFE_CAST(taxa_atraso_1_basico AS FLOAT64) taxa_atraso_1_basico,
SAFE_CAST(taxa_atraso_1_fundamental AS FLOAT64) taxa_atraso_1_fundamental,
SAFE_CAST(taxa_atraso_1_medio AS FLOAT64) taxa_atraso_1_medio,
SAFE_CAST(taxa_atraso_2_basico AS FLOAT64) taxa_atraso_2_basico,
SAFE_CAST(taxa_atraso_2_fundamental AS FLOAT64) taxa_atraso_2_fundamental,
SAFE_CAST(taxa_atraso_2_medio AS FLOAT64) taxa_atraso_2_medio,
SAFE_CAST(taxa_freq_bruta_basico AS FLOAT64) taxa_freq_bruta_basico,
SAFE_CAST(taxa_freq_bruta_fundamental AS FLOAT64) taxa_freq_bruta_fundamental,
SAFE_CAST(taxa_freq_bruta_medio AS FLOAT64) taxa_freq_bruta_medio,
SAFE_CAST(taxa_freq_bruta_pre AS FLOAT64) taxa_freq_bruta_pre,
SAFE_CAST(taxa_freq_bruta_superior AS FLOAT64) taxa_freq_bruta_superior,
SAFE_CAST(taxa_freq_liquida_basico AS FLOAT64) taxa_freq_liquida_basico,
SAFE_CAST(taxa_freq_liquida_fundamental AS FLOAT64) taxa_freq_liquida_fundamental,
SAFE_CAST(taxa_freq_liquida_medio AS FLOAT64) taxa_freq_liquida_medio,
SAFE_CAST(taxa_freq_liquida_pre AS FLOAT64) taxa_freq_liquida_pre,
SAFE_CAST(taxa_freq_liquida_superior AS FLOAT64) taxa_freq_liquida_superior,
SAFE_CAST(taxa_freq_0_3 AS FLOAT64) taxa_freq_0_3,
SAFE_CAST(taxa_freq_11_14 AS FLOAT64) taxa_freq_11_14,
SAFE_CAST(taxa_freq_15_17 AS FLOAT64) taxa_freq_15_17,
SAFE_CAST(taxa_freq_18_24 AS FLOAT64) taxa_freq_18_24,
SAFE_CAST(taxa_freq_25_29 AS FLOAT64) taxa_freq_25_29,
SAFE_CAST(taxa_freq_4_5 AS FLOAT64) taxa_freq_4_5,
SAFE_CAST(taxa_freq_4_6 AS FLOAT64) taxa_freq_4_6,
SAFE_CAST(taxa_freq_5_6 AS FLOAT64) taxa_freq_5_6,
SAFE_CAST(taxa_freq_6 AS FLOAT64) taxa_freq_6,
SAFE_CAST(taxa_freq_6_14 AS FLOAT64) taxa_freq_6_14,
SAFE_CAST(taxa_freq_6_17 AS FLOAT64) taxa_freq_6_17,
SAFE_CAST(taxa_freq_fundamental_15_17 AS FLOAT64) taxa_freq_fundamental_15_17,
SAFE_CAST(taxa_freq_fundamental_18_24 AS FLOAT64) taxa_freq_fundamental_18_24,
SAFE_CAST(taxa_freq_fundamental_4_5 AS FLOAT64) taxa_freq_fundamental_4_5,
SAFE_CAST(taxa_freq_medio_18_24 AS FLOAT64) taxa_freq_medio_18_24,
SAFE_CAST(taxa_freq_medio_6_14 AS FLOAT64) taxa_freq_medio_6_14,
SAFE_CAST(taxa_freq_superior_15_17 AS FLOAT64) taxa_freq_superior_15_17,
SAFE_CAST(taxa_fundamental_11_13 AS FLOAT64) taxa_fundamental_11_13,
SAFE_CAST(taxa_fundamental_12_14 AS FLOAT64) taxa_fundamental_12_14,
SAFE_CAST(taxa_fundamental_15_17 AS FLOAT64) taxa_fundamental_15_17,
SAFE_CAST(taxa_fundamental_16_18 AS FLOAT64) taxa_fundamental_16_18,
SAFE_CAST(taxa_fundamental_18_24 AS FLOAT64) taxa_fundamental_18_24,
SAFE_CAST(taxa_fundamental_18_mais AS FLOAT64) taxa_fundamental_18_mais,
SAFE_CAST(taxa_fundamental_25_mais AS FLOAT64) taxa_fundamental_25_mais,
SAFE_CAST(taxa_medio_18_20 AS FLOAT64) taxa_medio_18_20,
SAFE_CAST(taxa_medio_18_24 AS FLOAT64) taxa_medio_18_24,
SAFE_CAST(taxa_medio_18_mais AS FLOAT64) taxa_medio_18_mais,
SAFE_CAST(taxa_medio_19_21 AS FLOAT64) taxa_medio_19_21,
SAFE_CAST(taxa_medio_25_mais AS FLOAT64) taxa_medio_25_mais,
SAFE_CAST(taxa_superior_25_mais AS FLOAT64) taxa_superior_25_mais,
SAFE_CAST(renda_pc_max_quintil_1 AS FLOAT64) renda_pc_max_quintil_1,
SAFE_CAST(renda_pc_max_quintil_2 AS FLOAT64) renda_pc_max_quintil_2,
SAFE_CAST(renda_pc_max_quintil_3 AS FLOAT64) renda_pc_max_quintil_3,
SAFE_CAST(renda_pc_max_quintil_4 AS FLOAT64) renda_pc_max_quintil_4,
SAFE_CAST(renda_pc_max_decil_9 AS FLOAT64) renda_pc_max_decil_9,
SAFE_CAST(indice_gini AS FLOAT64) indice_gini,
SAFE_CAST(prop_pobreza_extrema AS FLOAT64) prop_pobreza_extrema,
SAFE_CAST(prop_pobreza_extrema_criancas AS FLOAT64) prop_pobreza_extrema_criancas,
SAFE_CAST(prop_pobreza AS FLOAT64) prop_pobreza,
SAFE_CAST(prop_pobreza_criancas AS FLOAT64) prop_pobreza_criancas,
SAFE_CAST(prop_vulner_pobreza AS FLOAT64) prop_vulner_pobreza,
SAFE_CAST(prop_vulner_pobreza_criancas AS FLOAT64) prop_vulner_pobreza_criancas,
SAFE_CAST(prop_renda_10_ricos AS FLOAT64) prop_renda_10_ricos,
SAFE_CAST(prop_renda_20_pobres AS FLOAT64) prop_renda_20_pobres,
SAFE_CAST(prop_renda_20_ricos AS FLOAT64) prop_renda_20_ricos,
SAFE_CAST(prop_renda_40_pobres AS FLOAT64) prop_renda_40_pobres,
SAFE_CAST(prop_renda_60_pobres AS FLOAT64) prop_renda_60_pobres,
SAFE_CAST(prop_renda_80_pobres AS FLOAT64) prop_renda_80_pobres,
SAFE_CAST(prop_renda_trabalho AS FLOAT64) prop_renda_trabalho,
SAFE_CAST(razao_10_ricos_40_pobres AS FLOAT64) razao_10_ricos_40_pobres,
SAFE_CAST(razao_20_ricos_40_pobres AS FLOAT64) razao_20_ricos_40_pobres,
SAFE_CAST(renda_pc AS FLOAT64) renda_pc,
SAFE_CAST(renda_pc_quintil_1 AS FLOAT64) renda_pc_quintil_1,
SAFE_CAST(renda_pc_decil_10 AS FLOAT64) renda_pc_decil_10,
SAFE_CAST(renda_pc_quintil_2 AS FLOAT64) renda_pc_quintil_2,
SAFE_CAST(renda_pc_quintil_3 AS FLOAT64) renda_pc_quintil_3,
SAFE_CAST(renda_pc_quintil_4 AS FLOAT64) renda_pc_quintil_4,
SAFE_CAST(renda_pc_quintil_5 AS FLOAT64) renda_pc_quintil_5,
SAFE_CAST(renda_pc_exc_renda_nula AS FLOAT64) renda_pc_exc_renda_nula,
SAFE_CAST(renda_pc_pobreza_extrema AS FLOAT64) renda_pc_pobreza_extrema,
SAFE_CAST(renda_pc_pobreza AS FLOAT64) renda_pc_pobreza,
SAFE_CAST(renda_pc_vulner_pobreza AS FLOAT64) renda_pc_vulner_pobreza,
SAFE_CAST(indice_theil AS FLOAT64) indice_theil,
SAFE_CAST(prop_trabalhadores_conta_proria AS FLOAT64) prop_trabalhadores_conta_proria,
SAFE_CAST(prop_empregadores AS FLOAT64) prop_empregadores,
SAFE_CAST(prop_ocupados_agropecuaria AS FLOAT64) prop_ocupados_agropecuaria,
SAFE_CAST(prop_ocupados_comercio AS FLOAT64) prop_ocupados_comercio,
SAFE_CAST(prop_ocupados_construcao AS FLOAT64) prop_ocupados_construcao,
SAFE_CAST(prop_ocupados_extracao AS FLOAT64) prop_ocupados_extracao,
SAFE_CAST(prop_ocupados_formalizacao AS FLOAT64) prop_ocupados_formalizacao,
SAFE_CAST(prop_ocupados_fundamental AS FLOAT64) prop_ocupados_fundamental,
SAFE_CAST(prop_ocupados_medio AS FLOAT64) prop_ocupados_medio,
SAFE_CAST(prop_ocupados_servicos AS FLOAT64) prop_ocupados_servicos,
SAFE_CAST(prop_ocupados_siup AS FLOAT64) prop_ocupados_siup,
SAFE_CAST(prop_ocupados_superior AS FLOAT64) prop_ocupados_superior,
SAFE_CAST(prop_ocupados_transformacao AS FLOAT64) prop_ocupados_transformacao,
SAFE_CAST(prop_ocupados_renda_0 AS FLOAT64) prop_ocupados_renda_0,
SAFE_CAST(prop_ocupados_renda_1_sm AS FLOAT64) prop_ocupados_renda_1_sm,
SAFE_CAST(prop_ocupados_renda_2_sm AS FLOAT64) prop_ocupados_renda_2_sm,
SAFE_CAST(prop_ocupados_renda_3_sm AS FLOAT64) prop_ocupados_renda_3_sm,
SAFE_CAST(prop_ocupados_renda_5_sm AS FLOAT64) prop_ocupados_renda_5_sm,
SAFE_CAST(renda_media_ocupados AS FLOAT64) renda_media_ocupados,
SAFE_CAST(taxa_atividade AS FLOAT64) taxa_atividade,
SAFE_CAST(taxa_atividade_10_14 AS FLOAT64) taxa_atividade_10_14,
SAFE_CAST(taxa_atividade_15_17 AS FLOAT64) taxa_atividade_15_17,
SAFE_CAST(taxa_atividade_18_24 AS FLOAT64) taxa_atividade_18_24,
SAFE_CAST(taxa_atividade_18_mais AS FLOAT64) taxa_atividade_18_mais,
SAFE_CAST(taxa_atividade_25_29 AS FLOAT64) taxa_atividade_25_29,
SAFE_CAST(taxa_desocupacao AS FLOAT64) taxa_desocupacao,
SAFE_CAST(taxa_desocupacao_10_14 AS FLOAT64) taxa_desocupacao_10_14,
SAFE_CAST(taxa_desocupacao_15_17 AS FLOAT64) taxa_desocupacao_15_17,
SAFE_CAST(taxa_desocupacao_18_24 AS FLOAT64) taxa_desocupacao_18_24,
SAFE_CAST(taxa_desocupacao_18_mais AS FLOAT64) taxa_desocupacao_18_mais,
SAFE_CAST(taxa_desocupacao_25_29 AS FLOAT64) taxa_desocupacao_25_29,
SAFE_CAST(indice_treil_trabalho AS FLOAT64) indice_treil_trabalho,
SAFE_CAST(taxa_ocupados_carteira AS FLOAT64) taxa_ocupados_carteira,
SAFE_CAST(taxa_ocupados_setor_publico AS FLOAT64) taxa_ocupados_setor_publico,
SAFE_CAST(taxa_ocupados_sem_carteira AS FLOAT64) taxa_ocupados_sem_carteira,
SAFE_CAST(taxa_agua_encanada AS FLOAT64) taxa_agua_encanada,
SAFE_CAST(taxa_banheiro_agua_encanada AS FLOAT64) taxa_banheiro_agua_encanada,
SAFE_CAST(taxa_densidade_2_mais AS FLOAT64) taxa_densidade_2_mais,
SAFE_CAST(taxa_coleta_lixo AS FLOAT64) taxa_coleta_lixo,
SAFE_CAST(taxa_energia_eletrica AS FLOAT64) taxa_energia_eletrica,
SAFE_CAST(taxa_agua_esgoto_inadequados AS FLOAT64) taxa_agua_esgoto_inadequados,
SAFE_CAST(taxa_paredes_inadequados AS FLOAT64) taxa_paredes_inadequados,
SAFE_CAST(taxa_criancas_dom_sem_fund AS FLOAT64) taxa_criancas_dom_sem_fund,
SAFE_CAST(taxa_criancas_fora_escola_4_5 AS FLOAT64) taxa_criancas_fora_escola_4_5,
SAFE_CAST(taxa_criancas_fora_escola_6_14 AS FLOAT64) taxa_criancas_fora_escola_6_14,
SAFE_CAST(taxa_dom_sem_fund AS FLOAT64) taxa_dom_sem_fund,
SAFE_CAST(taxa_dom_vulner_sem_fund AS FLOAT64) taxa_dom_vulner_sem_fund,
SAFE_CAST(taxa_sem_fund_informal AS FLOAT64) taxa_sem_fund_informal,
SAFE_CAST(taxa_mulheres_com_filho_10_14 AS FLOAT64) taxa_mulheres_com_filho_10_14,
SAFE_CAST(taxa_mulheres_com_filho_15_17 AS FLOAT64) taxa_mulheres_com_filho_15_17,
SAFE_CAST(taxa_mulheres_chefe_filho_15m AS FLOAT64) taxa_mulheres_chefe_filho_15m,
SAFE_CAST(taxa_nest_ntrab_vulner_15_24 AS FLOAT64) taxa_nest_ntrab_vulner_15_24,
SAFE_CAST(taxa_vulner_desloc_1_hora AS FLOAT64) taxa_vulner_desloc_1_hora,
SAFE_CAST(taxa_dom_vulner_dep_idoso AS FLOAT64) taxa_dom_vulner_dep_idoso,
SAFE_CAST(taxa_sem_energia_eletrica AS FLOAT64) taxa_sem_energia_eletrica,
SAFE_CAST(populacao_homens_0_4 AS INT64) populacao_homens_0_4,
SAFE_CAST(populacao_homens_10_14 AS INT64) populacao_homens_10_14,
SAFE_CAST(populacao_homens_15_19 AS INT64) populacao_homens_15_19,
SAFE_CAST(populacao_homens_20_24 AS INT64) populacao_homens_20_24,
SAFE_CAST(populacao_homens_25_29 AS INT64) populacao_homens_25_29,
SAFE_CAST(populacao_homens_30_34 AS INT64) populacao_homens_30_34,
SAFE_CAST(populacao_homens_35_39 AS INT64) populacao_homens_35_39,
SAFE_CAST(populacao_homens_40_44 AS INT64) populacao_homens_40_44,
SAFE_CAST(populacao_homens_45_49 AS INT64) populacao_homens_45_49,
SAFE_CAST(populacao_homens_50_54 AS INT64) populacao_homens_50_54,
SAFE_CAST(populacao_homens_55_59 AS INT64) populacao_homens_55_59,
SAFE_CAST(populacao_homens_5_9 AS INT64) populacao_homens_5_9,
SAFE_CAST(populacao_homens_60_64 AS INT64) populacao_homens_60_64,
SAFE_CAST(populacao_homens_65_69 AS INT64) populacao_homens_65_69,
SAFE_CAST(populacao_homens_70_74 AS INT64) populacao_homens_70_74,
SAFE_CAST(populacao_homens_75_79 AS INT64) populacao_homens_75_79,
SAFE_CAST(populacao_homens AS INT64) populacao_homens,
SAFE_CAST(populacao_homens_80_mais AS INT64) populacao_homens_80_mais,
SAFE_CAST(populacao_mulheres_0_4 AS INT64) populacao_mulheres_0_4,
SAFE_CAST(populacao_mulheres_10_14 AS INT64) populacao_mulheres_10_14,
SAFE_CAST(populacao_mulheres_15_19 AS INT64) populacao_mulheres_15_19,
SAFE_CAST(populacao_mulheres_20_24 AS INT64) populacao_mulheres_20_24,
SAFE_CAST(populacao_mulheres_25_29 AS INT64) populacao_mulheres_25_29,
SAFE_CAST(populacao_mulheres_30_34 AS INT64) populacao_mulheres_30_34,
SAFE_CAST(populacao_mulheres_35_39 AS INT64) populacao_mulheres_35_39,
SAFE_CAST(populacao_mulheres_40_44 AS INT64) populacao_mulheres_40_44,
SAFE_CAST(populacao_mulheres_45_49 AS INT64) populacao_mulheres_45_49,
SAFE_CAST(populacao_mulheres_50_54 AS INT64) populacao_mulheres_50_54,
SAFE_CAST(populacao_mulheres_55_59 AS INT64) populacao_mulheres_55_59,
SAFE_CAST(populacao_mulheres_5_9 AS INT64) populacao_mulheres_5_9,
SAFE_CAST(populacao_mulheres_60_64 AS INT64) populacao_mulheres_60_64,
SAFE_CAST(populacao_mulheres_65_69 AS INT64) populacao_mulheres_65_69,
SAFE_CAST(populacao_mulheres_70_74 AS INT64) populacao_mulheres_70_74,
SAFE_CAST(populacao_mulheres_75_79 AS INT64) populacao_mulheres_75_79,
SAFE_CAST(populacao_mulheres_80_mais AS INT64) populacao_mulheres_80_mais,
SAFE_CAST(populacao_mulheres AS INT64) populacao_mulheres,
SAFE_CAST(populacao_1_menos AS INT64) populacao_1_menos,
SAFE_CAST(populacao_11_14 AS INT64) populacao_11_14,
SAFE_CAST(populacao_11_13 AS INT64) populacao_11_13,
SAFE_CAST(populacao_12_14 AS INT64) populacao_12_14,
SAFE_CAST(populacao_1_3 AS INT64) populacao_1_3,
SAFE_CAST(populacao_15_mais AS INT64) populacao_15_mais,
SAFE_CAST(populacao_15_17 AS INT64) populacao_15_17,
SAFE_CAST(populacao_15_24 AS INT64) populacao_15_24,
SAFE_CAST(populacao_16_18 AS INT64) populacao_16_18,
SAFE_CAST(populacao_18_mais AS INT64) populacao_18_mais,
SAFE_CAST(populacao_18_20 AS INT64) populacao_18_20,
SAFE_CAST(populacao_18_24 AS INT64) populacao_18_24,
SAFE_CAST(populacao_19_21 AS INT64) populacao_19_21,
SAFE_CAST(populacao_25_mais AS INT64) populacao_25_mais,
SAFE_CAST(populacao_4 AS INT64) populacao_4,
SAFE_CAST(populacao_5 AS INT64) populacao_5,
SAFE_CAST(populacao_6 AS INT64) populacao_6,
SAFE_CAST(populacao_6_10 AS INT64) populacao_6_10,
SAFE_CAST(populacao_6_17 AS INT64) populacao_6_17,
SAFE_CAST(populacao_65_mais AS INT64) populacao_65_mais,
SAFE_CAST(populacao AS INT64) populacao,
SAFE_CAST(populacao_urbana AS INT64) populacao_urbana,
SAFE_CAST(populacao_rural AS INT64) populacao_rural,
SAFE_CAST(populacao_dom_pp AS INT64) populacao_dom_pp,
SAFE_CAST(populacao_dom_pp_exc_renda_nula AS INT64) populacao_dom_pp_exc_renda_nula,
SAFE_CAST(pea AS FLOAT64) pea,
SAFE_CAST(pea_10_14 AS FLOAT64) pea_10_14,
SAFE_CAST(pea_15_17 AS FLOAT64) pea_15_17,
SAFE_CAST(pea_18_mais AS FLOAT64) pea_18_mais,
SAFE_CAST(pia AS FLOAT64) pia,
SAFE_CAST(pia_10_14 AS FLOAT64) pia_10_14,
SAFE_CAST(pia_15_17 AS FLOAT64) pia_15_17,
SAFE_CAST(pia_18_mais AS FLOAT64) pia_18_mais,
SAFE_CAST(indice_escolaridade AS FLOAT64) indice_escolaridade,
SAFE_CAST(indice_frequencia_escolar AS FLOAT64) indice_frequencia_escolar,
SAFE_CAST(idhm AS FLOAT64) idhm,
SAFE_CAST(idhm_e AS FLOAT64) idhm_e,
SAFE_CAST(idhm_l AS FLOAT64) idhm_l,
SAFE_CAST(idhm_r AS FLOAT64) idhm_r
from basedosdados-staging.mundo_onu_adh_staging.estados as t