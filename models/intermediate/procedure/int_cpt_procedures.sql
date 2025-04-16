select 
    cast(concat(cpt.hsp_account_id,'|',cpt.line) as {{ dbt.type_string() }}) as procedure_id,
    -- {{ sha_hash_512('cpt.hsp_account_id||cpt.line') }} as procedure_id,
    cast(hsp.pat_id as {{ dbt.type_string() }}) as person_id,
    cast(hsp.pat_id as {{ dbt.type_string() }}) as patient_id,
    cast(hsp.pat_enc_csn_id as {{ dbt.type_string() }}) as encounter_id,
    cast(null as {{ dbt.type_string() }}) as claim_id,
    cast(cpt.cpt_code_date as {{ dbt.type_timestamp() }}) as procedure_date,
    cast('cpt' as {{ dbt.type_string() }}) as source_code_type,
    cast(cpt.cpt_code as {{ dbt.type_string() }}) as source_code,
    cast(cpt.cpt_code_description as {{ dbt.type_string() }}) as source_description,
    cast(null as {{ dbt.type_string() }}) as normalized_code_type,
    cast(null as {{ dbt.type_string() }}) as normalized_code,
    cast(null as {{ dbt.type_string() }}) as normalized_description,
    cast(null as {{ dbt.type_string() }}) as modifier_1,
    cast(null as {{ dbt.type_string() }}) as modifier_2,
    cast(null as {{ dbt.type_string() }}) as modifier_3,
    cast(null as {{ dbt.type_string() }}) as modifier_4,
    cast(null as {{ dbt.type_string() }}) as modifier_5,
    cast(cpt.perf_prov_id as {{ dbt.type_string() }}) as practitioner_id,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__hsp_account_cpt_codes') }} as cpt
    inner join {{ ref('stg_epic__hsp_account') }} as hsp 
    on cpt.hsp_account_id = hsp.hsp_account_id