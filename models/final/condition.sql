{{ dbt_utils.union_relations(
    relations=[ ref('int_clinical_diagnoses'),
                ref('int_problem_lists')]
) }}