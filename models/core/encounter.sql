select 
    -- Assuming pat_enc_csn_id is unique for each encounter
    cast(pat_enc_csn_id as varchar(50)) AS encounter_id,
    cast(pat_id as varchar(50)) AS person_id,
    cast(pat_id as varchar(50)) AS patient_id,
    -- enc_type_c might need a join with a lookup table for human-readable encounter types
    cast(enc_type_c as varchar(100)) AS encounter_type,
    cast(contact_date as date) as encounter_start_date,
    cast(null as date) as encounter_end_date,  -- No direct mapping for end date
    cast(null as decimal(18,2)) as length_of_stay,  -- Would need to calculate from start and end dates
    cast(null as varchar(100)) as admit_source_code,
    cast(null as varchar(100)) as admit_source_description,
    cast(null as varchar(100)) as admit_type_code,
    cast(null as varchar(100)) as admit_type_description,
    cast(null as varchar(100)) as discharge_disposition_code,
    cast(null as varchar(100)) as discharge_disposition_description,
    cast(visit_prov_id as varchar(50)) as attending_provider_id,
    -- Provider name would need to be joined from another table
    cast(null as varchar(100)) as attending_provider_name,
    -- Assuming primary_loc_id is used as facility_id
    cast(primary_loc_id as varchar(50)) as facility_id,
    -- Facility name would need to be joined from another table
    cast(null as varchar(100)) as facility_name,
    cast(null as varchar(100)) as primary_diagnosis_code_type,
    cast(null as varchar(100)) as primary_diagnosis_code,
    cast(null as varchar(255)) as primary_diagnosis_description,
    cast(null as varchar(100)) as ms_drg_code,
    cast(null as varchar(255)) as ms_drg_description,
    cast(null as varchar(100)) as apr_drg_code,
    cast(null as varchar(255)) as apr_drg_description,
    cast(null as decimal(18,2)) as paid_amount,
    cast(null as decimal(18,2)) as allowed_amount,
    cast(null as decimal(18,2)) as charge_amount,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'pat_enc') }}