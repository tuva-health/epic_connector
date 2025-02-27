select 
    cast(concat(p.pat_enc_csn_id, '-', p.line) as varchar(50)) as condition_id,
    cast(null as varchar(50)) as person_id,
    cast(null as varchar(50)) as member_id,
    cast(p.pat_id as varchar(50)) as patient_id,
    cast(p.pat_enc_csn_id as varchar(50)) as encounter_id,
    cast(null as varchar(50)) as claim_id,
    cast(pe.contact_date as date) as recorded_date,
    cast(pe.contact_date as date) as onset_date,
    cast(null as date) as resolved_date,
    cast(null as varchar(100)) as status,
    cast(null as varchar(100)) as condition_type,
    cast(case when c.icd10_code is not null then 'ICD-10' else 'ICD-9' end as varchar(100)) as source_code_type,
    cast(coalesce(c.icd10_code, c.icd9_code) as varchar(100)) as source_code,
    cast(c.dx_name as varchar(255)) as source_description,
    cast(case when c.icd10_code is not null then 'ICD-10' else 'ICD-9' end as varchar(100)) as normalized_code_type,
    cast(coalesce(c.icd10_code, c.icd9_code) as varchar(100)) as normalized_code,
    cast(c.dx_name as varchar(255)) as normalized_description,
    cast('Direct' as varchar(100)) as mapping_method,
    cast(p.line as int) as condition_rank,
    cast(null as varchar(100)) as present_on_admit_code,
    cast(null as varchar(255)) as present_on_admit_description,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic','pat_enc_dx') }} p
inner join {{ source('epic','pat_enc') }} pe 
    on p.pat_enc_csn_id = pe.pat_enc_csn_id
left join {{ source('epic','clarity_edg') }} c 
    on p.dx_id = c.dx_id