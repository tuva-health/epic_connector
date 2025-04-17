select 
    county_c,
    name 
from {{ source('epic','zc_county') }}