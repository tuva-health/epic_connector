select 
    hsp_account_id,
    pat_id,
    pat_enc_csn_id,
    adm_date_time,
    disch_date_time,
    admission_source_c,
    admission_type_c,
    patient_status_c
from {{ source('epic','hsp_account') }}