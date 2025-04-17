-- This will provide all medication orders.
-- To get administrations, you'll want to bring in the mar_admin_info table. 
-- To get immunizations, you'll want to bring in the immune table.
select 
    cast(om.order_med_id as {{ dbt.type_string() }}) as medication_id,
    cast(om.pat_id as {{ dbt.type_string() }}) as person_id,
    cast(om.pat_id as {{ dbt.type_string() }}) as patient_id,
    cast(om.pat_enc_csn_id as {{ dbt.type_string() }}) as encounter_id,
    cast(null as date) as dispensing_date,
    cast(om.order_inst as date) as prescribing_date,
    cast(null as {{ dbt.type_string() }}) as source_code_type,
    cast(om.order_med_id as {{ dbt.type_string() }}) as source_code,
    cast(med.name as {{ dbt.type_string() }}) as source_description,
    cast(null as {{ dbt.type_string() }}) as ndc_code,
    cast(null as {{ dbt.type_string() }}) as ndc_description,
    cast(null as {{ dbt.type_string() }}) as rxnorm_code,
    cast(null as {{ dbt.type_string() }}) as rxnorm_description,
    cast(null as {{ dbt.type_string() }}) as atc_code,
    cast(null as {{ dbt.type_string() }}) as atc_description,
    cast(null as {{ dbt.type_string() }}) as route,
    cast(med.strength as {{ dbt.type_string() }}) as strength,
    cast(om.quantity as {{ dbt.type_numeric() }}) as quantity,
    cast(null as {{ dbt.type_string() }}) as quantity_unit,
    cast(null as {{ dbt.type_numeric() }}) as days_supply,
    cast(om.authrzing_prov_id as {{ dbt.type_string() }}) as practitioner_id,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__order_med') }} as om
    inner join {{ ref('stg_epic__order_medinfo') }} as om_info
    on om.order_med_id = om_info.order_med_id
    inner join {{ ref('stg_epic__clarity_medication') }} as med
    on om_info.medication_id = med.medication_id
    left outer join {{ ref('stg_epic__zc_admin_route') }} as zc_admin_route
    on zc_admin_route.route_c = med.route_c
where om.is_pending_ord_yn <> 'Y' -- Exclude pending orders as these are not done yet.
    and om.order_status_c <> 4 -- Exclude Canceled. Check if there are other org-specific values you'd want to exclude.