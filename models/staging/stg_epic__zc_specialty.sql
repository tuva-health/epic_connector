select 
    specialty_c,
    name 
from {{ source('epic','zc_specialty') }}