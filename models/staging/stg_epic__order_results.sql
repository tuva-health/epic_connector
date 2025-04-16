select 
    order_proc_id,
    ord_date_real,
    line,
    pat_id,
    pat_enc_csn_id,
    component_id,
    ord_value,
    ord_num_value
    result_status_c,
    result_time,
    reference_unit,
    reference_low,
    reference_high,
    result_in_range_yn
from {{ source('epic','order_results') }}