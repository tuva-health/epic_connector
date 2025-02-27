select 
    cast(ser.prov_id as varchar(50)) as practitioner_id,
    cast(null as varchar(50)) as npi,
    cast(ser.prov_name as varchar(255)) as first_name,
    cast(null as varchar(255)) as last_name,
    cast(null as varchar(100)) as practice_affiliation,
    cast(null as varchar(100)) as specialty,
    cast(null as varchar(100)) as sub_specialty,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'clarity_ser') }} AS ser