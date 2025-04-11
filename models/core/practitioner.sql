select 
    cast(ser.prov_id as varchar(50)) as practitioner_id,
    cast(null as varchar(50)) as npi,
    cast(string_split(prov_name, ' ')[1] as varchar(255)) as first_name,
    cast(string_split(prov_name, ' ')[array_length(string_split(prov_name, ' '))] as varchar(255)) as last_name,
    cast(null as varchar(100)) as practice_affiliation,
    cast(zsp.name as varchar(100)) as specialty,
    cast(null as varchar(100)) as sub_specialty,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'clarity_ser') }} AS ser
    left join {{ source('epic', 'clarity_ser_spec') }} as ser_spec
    on ser.prov_id = ser_spec.prov_id
    and ser_spec.line = 1
    left join {{ source('epic', 'zc_specialty') }} as zsp
    on zsp.specialty_c = ser_spec.specialty_c