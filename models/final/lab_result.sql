-- Need a filter on order_type_c to get only lab results. This may be "LAB", but may include other org-specific values. e.g. Microbiology is usually under a different type.
-- May want to also add a filter to only get completed results.
-- Note that order_result.ord_num_value is a numeric representation on the result. This may be desired instead of the text value
-- however, be aware that in cases where the result is non-numeric, this field will show 9999999.

select 
    cast(concat(order_result.order_proc_id,'-',order_result.ord_date_real,'-',order_result.line) as {{ dbt.type_string() }}) as lab_result_id,
    cast(order_result.pat_id as {{ dbt.type_string() }}) as person_id,
    cast(order_result.pat_id as {{ dbt.type_string() }}) as patient_id,
    cast(order_result.pat_enc_csn_id as {{ dbt.type_string() }}) as encounter_id,
    cast(null as {{ dbt.type_string() }}) as accession_number,
    cast('epic.proc_id' as {{ dbt.type_string() }}) as source_code_type,
    cast(eap.proc_code as {{ dbt.type_string() }}) as source_code,
    cast(eap.proc_name as {{ dbt.type_string() }}) as source_description,
    cast(order_result.component_id as {{ dbt.type_string() }}) as source_component,
    cast(null as {{ dbt.type_string() }}) as normalized_code_type,
    cast(null as {{ dbt.type_string() }}) as normalized_code,
    cast(null as {{ dbt.type_string() }}) as normalized_description,
    cast(null as {{ dbt.type_string() }}) as normalized_component,
    cast(order_result.result_status_c as {{ dbt.type_string() }}) as status,
    cast(order_result.ord_value as {{ dbt.type_string() }}) as result,
    cast(order_result.result_time as date) as result_date,
    cast(order_proc_2.specimn_taken_time as date) as collection_date, 
    cast(order_result.reference_unit as {{ dbt.type_string() }}) as source_units,
    cast(null as {{ dbt.type_string() }}) as normalized_units,
    cast(order_result.reference_low as {{ dbt.type_string() }}) as source_reference_range_low,
    cast(order_result.reference_high as {{ dbt.type_string() }}) as source_reference_range_high,
    cast(null as {{ dbt.type_string() }}) as normalized_reference_range_low,
    cast(null as {{ dbt.type_string() }}) as normalized_reference_range_high,
    cast(case when order_result.result_in_range_yn = 'N' then 1 else 0 end as {{ dbt.type_int() }}) as source_abnormal_flag,
    cast(null as {{ dbt.type_int() }}) as normalized_abnormal_flag,
    cast(order_proc.specimen_type_c as {{ dbt.type_string() }}) as specimen,
    cast(order_proc.authrzing_prov_id as {{ dbt.type_string() }}) as ordering_practitioner_id,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__order_results') }} as order_result
    inner join {{ ref('stg_epic__order_proc') }} as order_proc 
    on order_proc.order_proc_id = order_result.order_proc_id
    inner join {{ ref('stg_epic__order_proc_2') }} as order_proc_2 
    on order_proc.order_proc_id = order_proc_2.order_proc_id
    left outer join {{ ref('stg_epic__clarity_eap') }} as eap 
    on order_proc.proc_id = eap.proc_id