select 
    route_c,
    name 
from {{ source('epic','zc_admin_route') }}