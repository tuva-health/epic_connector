select 
    cast(concat(pxlist.hsp_account_id, '|', pxlist.line) as {{ dbt.type_string() }}) as procedure_id,
    -- {{ sha_hash_512('pxlist.hsp_account_id||pxlist.line') }} as procedure_id,
    cast(hsp.pat_id as {{ dbt.type_string() }}) as person_id,
    cast(hsp.pat_id as {{ dbt.type_string() }}) as patient_id,
    cast(hsp.pat_enc_csn_id as {{ dbt.type_string() }}) as encounter_id,
    cast(null as {{ dbt.type_string() }}) as claim_id,
    cast(pxlist.proc_date as {{ dbt.type_timestamp() }}) as procedure_date,
    cast('icd-10-pcs' as {{ dbt.type_string() }}) as source_code_type,
    cast(pxlist.final_icd_px_id as {{ dbt.type_string() }}) as source_code,
    cast(null as {{ dbt.type_string() }}) as source_description,
    cast(null as {{ dbt.type_string() }}) as normalized_code_type,
    cast(null as {{ dbt.type_string() }}) as normalized_code,
    cast(null as {{ dbt.type_string() }}) as normalized_description,
    cast(null as {{ dbt.type_string() }}) as modifier_1,
    cast(null as {{ dbt.type_string() }}) as modifier_2,
    cast(null as {{ dbt.type_string() }}) as modifier_3,
    cast(null as {{ dbt.type_string() }}) as modifier_4,
    cast(null as {{ dbt.type_string() }}) as modifier_5,
    cast(pxlist.proc_perf_prov_id as {{ dbt.type_string() }}) as practitioner_id,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__hsp_account_px_list') }} as pxlist
    inner join {{ ref('stg_epic__hsp_account') }} as hsp
    on pxlist.hsp_account_id = hsp.hsp_account_id
    left join {{ ref('stg_epic__clarity_eap') }} as eap
    on pxlist.final_icd_px_id = eap.proc_id