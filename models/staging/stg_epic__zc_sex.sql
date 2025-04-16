select 
    sex_c,
    name 
from {{ source('epic','zc_sex') }}