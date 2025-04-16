select 
    state_c,
    name 
from {{ source('epic','zc_state') }}