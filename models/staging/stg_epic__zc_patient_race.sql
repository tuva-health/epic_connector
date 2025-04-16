select 
    patient_race_c,
    name 
from {{ source('epic','zc_patient_race') }}