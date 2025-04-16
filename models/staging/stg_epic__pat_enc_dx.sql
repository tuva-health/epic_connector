select
    pat_enc_csn_id,
    line, -- indicates the priority of the diagnosis related to the encounter. 1 = primary, 2 = secondary, etc.
    pat_id,
    dx_id
from {{ source('epic','pat_enc_dx') }}