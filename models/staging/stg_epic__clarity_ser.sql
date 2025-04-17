select 
    prov_id, -- internal id for the provider
    prov_name, -- internal name of the provider
from {{ source('epic','clarity_ser') }}