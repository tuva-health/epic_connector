select 
    cast(concat(p.pat_enc_csn_id, '-', p.line) as {{ dbt.type_string() }}) as condition_id,
    -- {{ sha_hash_512('p.pat_enc_csn_id||p.line') }} as condition_id,
    cast(p.pat_id as {{ dbt.type_string() }}) as person_id,
    cast(p.pat_id as {{ dbt.type_string() }}) as patient_id,
    cast(p.pat_enc_csn_id as {{ dbt.type_string() }}) as encounter_id,
    cast(null as {{ dbt.type_string() }}) as claim_id,
    cast(pe.contact_date as date) as recorded_date,
    cast(pe.contact_date as date) as onset_date,
    cast(null as date) as resolved_date,
    cast(null as {{ dbt.type_string() }}) as status,
    cast('clinical diagnosis' as {{ dbt.type_string() }}) as condition_type,
    cast(case when c.icd10_code is not null then 'icd-10-cm' else 'icd-9-cm' end as {{ dbt.type_string() }}) as source_code_type,
    cast(coalesce(c.icd10_code, c.icd9_code) as {{ dbt.type_string() }}) as source_code,
    cast(c.dx_name as {{ dbt.type_string() }}) as source_description,
    cast(case when c.icd10_code is not null then 'icd-10-cm' else 'icd-9-cm' end as {{ dbt.type_string() }}) as normalized_code_type,
    cast(null as {{ dbt.type_string() }}) as normalized_code,
    cast(null as {{ dbt.type_string() }}) as normalized_description,
    cast(p.line as {{ dbt.type_int() }}) as condition_rank,
    cast(null as {{ dbt.type_string() }}) as present_on_admit_code,
    cast(null as {{ dbt.type_string() }}) as present_on_admit_description,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__pat_enc_dx') }} p
    inner join {{ ref('stg_epic__pat_enc') }} pe 
    on p.pat_enc_csn_id = pe.pat_enc_csn_id
    left join {{ ref('stg_epic__clarity_edg') }} c 
    on p.dx_id = c.dx_id