select
      cast(pp.problem_list_id as {{ dbt.type_string() }} ) as condition_id
    , cast(pp.pat_id as {{ dbt.type_string() }} ) as person_id
    , cast(pp.pat_id as {{ dbt.type_string() }} ) as patient_id
    , cast(null as {{ dbt.type_string() }} ) as encounter_id
    , cast(null as {{ dbt.type_string() }} ) as claim_id
    , cast(pp.date_of_entry as date) as recorded_date
    , cast(pp.noted_date as date) as onset_date
    , cast(pp.resolved_date as date) as resolved_date
    , cast(pp.problem_status_c as {{ dbt.type_string() }} ) as status
    , cast('problem' as {{ dbt.type_string() }} ) as condition_type
    , cast('icd10cm' as {{ dbt.type_string() }} ) as source_code_type
    , cast(c.icd10_code as {{ dbt.type_string() }} ) as source_code
    , cast(null as {{ dbt.type_string() }} ) as source_description
    , cast(null as {{ dbt.type_string() }} ) as normalized_code_type
    , cast(null as {{ dbt.type_string() }} ) as normalized_code
    , cast(null as {{ dbt.type_string() }} ) as normalized_description
    , cast(null as {{ dbt.type_int() }} ) as condition_rank
    , cast(null as {{ dbt.type_string() }} ) as present_on_admit_code
    , cast(null as {{ dbt.type_string() }} ) as present_on_admit_description
    , cast('epic'  as {{ dbt.type_string() }} ) as data_source
    , cast(null as {{ dbt.type_string() }} ) as file_name
    , cast(null as {{ dbt.type_timestamp() }} ) as ingest_datetime
from {{source('epic','problem_list')}} pp
inner join {{source('epic','clarity_edg')}} c
    on pp.dx_id = c.dx_id