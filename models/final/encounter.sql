
-- Might consider switching the main table to be HSP_ACCOUNT as that provides a more consistent set of data with what is 
-- derived from claims. As it is, you'd need to worry about duplicates in the billing fields if treating this the same as claims-based encounters.
-- To get primary diagnosis, go to hsp_account_dx_list. The primary is where line = 1.
-- To get drgs, go to hsp_account_drg_list (name may be different). Filter on drg type to populate the appropriate columns.
-- To get the appropriate description fields, join out to the appropriate ZC table and get the "name" field.

select 
    cast(enc.pat_enc_csn_id as {{ dbt.type_string() }}) AS encounter_id,
    cast(enc.pat_id as {{ dbt.type_string() }}) AS person_id,
    cast(enc.pat_id as {{ dbt.type_string() }}) AS patient_id,
    cast(enc.enc_type_c as {{ dbt.type_string() }}) AS encounter_type,
    cast(coalesce(hsp.adm_date_time, enc.contact_date) as date) as encounter_start_date,
    cast(hsp.disch_date_time as date) as encounter_end_date, 
    cast(null as {{ dbt.type_numeric() }}) as length_of_stay, 
    cast(hsp.admission_source_c as {{ dbt.type_string() }}) as admit_source_code,
    cast(null as {{ dbt.type_string() }}) as admit_source_description,
    cast(hsp.admission_type_c as {{ dbt.type_string() }}) as admit_type_code,
    cast(null as {{ dbt.type_string() }}) as admit_type_description,
    cast(hsp.patient_status_c as {{ dbt.type_string() }}) as discharge_disposition_code,
    cast(null as {{ dbt.type_string() }}) as discharge_disposition_description,
    cast(enc.visit_prov_id as {{ dbt.type_string() }}) as attending_provider_id,
    cast(ser.prov_name as {{ dbt.type_string() }}) as attending_provider_name,
    cast(enc.primary_loc_id as {{ dbt.type_string() }}) as facility_id,
    cast(loc.loc_name as {{ dbt.type_string() }}) as facility_name,
    cast(null as {{ dbt.type_string() }}) as primary_diagnosis_code_type,
    cast(null as {{ dbt.type_string() }}) as primary_diagnosis_code,
    cast(null as {{ dbt.type_string() }}) as primary_diagnosis_description,
    cast(null as {{ dbt.type_string() }}) as ms_drg_code,
    cast(null as {{ dbt.type_string() }}) as ms_drg_description,
    cast(null as {{ dbt.type_string() }}) as apr_drg_code,
    cast(null as {{ dbt.type_string() }}) as apr_drg_description,
    cast(null as {{ dbt.type_numeric() }}) as paid_amount,
    cast(null as {{ dbt.type_numeric() }}) as allowed_amount,
    cast(null as {{ dbt.type_numeric() }}) as charge_amount,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__pat_enc') }} as enc
    left outer join {{ ref('stg_epic__clarity_ser') }} as ser 
    on enc.visit_prov_id = ser.prov_id
    left outer join {{ ref('stg_epic__clarity_loc') }} as loc 
    on enc.primary_loc_id = loc.loc_id
    left outer join {{ ref('stg_epic__pat_enc_hsp') }} as enc_hsp 
    on enc.pat_enc_csn_id = enc_hsp.pat_enc_csn_id
    left outer join {{ ref('stg_epic__hsp_account') }} as hsp 
    on enc_hsp.hsp_account_id = hsp.hsp_account_id