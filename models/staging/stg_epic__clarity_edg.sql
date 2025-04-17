select 
    dx_id, -- internal id for the diagnosis
    dx_name, -- internal name of the diagnosis
    record_type_c, -- 1 = term, 2 = code, 3 = both code and term
    ref_bill_code, -- code used for billing
    ref_bill_code_set_c, -- the set of the bill code (icd version)
    icd9_code,
    icd10_code,
from {{ source('epic','clarity_edg') }} edg