{{ dbt_utils.union_relations(
    relations=[ ref('int_procedure_hsp_account_px_list'),
                ref('int_procedure_hsp_account_cpt_codes')]
) }}