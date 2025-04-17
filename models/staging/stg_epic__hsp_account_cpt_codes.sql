select 
    hsp_account_id,
    line,
    cpt_code_date,
    cpt_code,
    cpt_code_description,
    perf_prov_id
from {{ source('epic','hsp_account_cpt_codes') }}