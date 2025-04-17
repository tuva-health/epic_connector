select 
    pat_id,
    line,
    patient_race_c
from {{ source('epic','patient_race') }}