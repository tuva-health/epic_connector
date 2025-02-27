select 
    cast(null as varchar(50)) as location_id,
    cast(null as varchar(50)) as npi,
    cast(null as varchar(50)) as name,
    cast(null as varchar(100)) as facility_type,
    cast(null as varchar(100)) as parent_organization,
    cast(null as varchar(255)) as address,
    cast(null as varchar(50)) as city,
    cast(null as varchar(50)) as state,
    cast(null as varchar(50)) as zip_code,
    cast(null as float) as latitude,
    cast(null as float) as longitude,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'clarity_loc') }}