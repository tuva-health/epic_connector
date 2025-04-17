select 
    order_med_id,
    pat_id,
    pat_enc_csn_id,
    order_inst,
    order_med_id,
    quantity,
    authrzing_prov_id,
    is_pending_ord_yn,
    order_status_c
from {{ source('epic','order_med') }}