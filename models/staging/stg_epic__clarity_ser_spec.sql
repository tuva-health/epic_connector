select 
    prov_id,
    line,
    specialty_c
from {{ source('epic','clarity_ser_spec') }}