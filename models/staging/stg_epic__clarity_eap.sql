select 
    proc_id, -- internal id for the procedure
    proc_name, -- internal name of the procedure
    proc_code -- code used for billing
from {{ source('epic','clarity_eap') }}