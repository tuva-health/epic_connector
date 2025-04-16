select 
    cast(ser.prov_id as {{ dbt.type_string() }}) as practitioner_id,
    cast(null as {{ dbt.type_string() }}) as npi,
    cast(string_split(prov_name, ' ')[1] as {{ dbt.type_string() }}) as first_name,
    cast(string_split(prov_name, ' ')[array_length(string_split(prov_name, ' '))] as {{ dbt.type_string() }}) as last_name,
    cast(null as {{ dbt.type_string() }}) as practice_affiliation,
    cast(zsp.name as {{ dbt.type_string() }}) as specialty,
    cast(null as {{ dbt.type_string() }}) as sub_specialty,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__clarity_ser') }} AS ser
    left join {{ ref('stg_epic__clarity_ser_spec') }} as ser_spec
    on ser.prov_id = ser_spec.prov_id
    and ser_spec.line = 1
    left join {{ ref('stg_epic__zc_specialty') }} as zsp
    on zsp.specialty_c = ser_spec.specialty_c