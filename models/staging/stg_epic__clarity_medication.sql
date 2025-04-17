select 
    medication_id,
    name,
    strength,
    route_c
from {{ source('epic','clarity_medication') }}