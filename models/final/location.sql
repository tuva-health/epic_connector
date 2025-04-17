select 
    cast(loc.loc_id as {{ dbt.type_string() }}) as location_id,
    cast(null as {{ dbt.type_string() }}) as npi,
    cast(loc.loc_name as {{ dbt.type_string() }}) as name,
    cast(null as {{ dbt.type_string() }}) as facility_type,
    cast(null as {{ dbt.type_string() }}) as parent_organization,
    cast(null as {{ dbt.type_string() }}) as address,
    cast(null as {{ dbt.type_string() }}) as city,
    cast(null as {{ dbt.type_string() }}) as state,
    cast(null as {{ dbt.type_string() }}) as zip_code,
    cast(null as float) as latitude,
    cast(null as float) as longitude,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__clarity_loc') }} as loc