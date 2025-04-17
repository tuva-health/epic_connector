select 
    order_proc_id,
    pat_id,
    pat_enc_csn_id,
    proc_id,
    specimen_type_c,
    authrzing_prov_id
from {{ source('epic','order_proc') }}