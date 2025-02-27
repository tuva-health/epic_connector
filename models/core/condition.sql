{{ dbt_utils.union_relations(
    relations=[ ref('epic_stage__condition_encounter_dx'),
                ref('epic_stage__condition_problem_list')]
) }}