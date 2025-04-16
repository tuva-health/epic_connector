{{ dbt_utils.union_relations(
    relations=[ ref('int_cpt_procedures'),
                ref('int_icd_procedures')]
) }}