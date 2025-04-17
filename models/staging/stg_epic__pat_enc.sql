select 
    pat_enc_csn_id,
    pat_id,
    enc_type_c,
    contact_date,
    visit_prov_id,
    primary_loc_id,
    hsp_account_id
from {{ source('epic','pat_enc') }}