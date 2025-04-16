select 
    pat_enc_csn_id,
    hsp_account_id
from {{ source('epic','pat_enc_hsp') }}