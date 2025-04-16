select 
    hsp_account_id,
    line,
    proc_date,
    final_icd_px_id,
    proc_perf_prov_id
from {{ source('epic','hsp_account_px_list') }}