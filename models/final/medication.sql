{{ dbt_utils.union_relations(
    relations=[ ref('int_medication_orders')]
) }}