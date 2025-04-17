select 
    loc_id, -- internal id for the location
    loc_name -- internal name of the location
from {{ source('epic','clarity_loc') }}