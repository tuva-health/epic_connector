{{ dbt_utils.union_relations(
    relations=[ ref('int_condition_encounter_dx'),
                ref('int_condition_problem_list')]
) }}