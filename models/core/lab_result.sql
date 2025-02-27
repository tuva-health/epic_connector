select 
    cast(concat(order_result.order_proc_id,'-',order_result.ord_date_real,'-',order_result.line) as varchar(50)) as lab_result_id,
    cast(order_proc.pat_id as varchar(50)) as person_id,
    cast(order_proc.pat_id as varchar(50)) as patient_id,
    cast(order_proc.pat_enc_csn_id as varchar(50)) as encounter_id,
    cast(null as varchar(50)) as accession_number,
    cast(null as varchar(100)) as source_code_type,
    cast(eap.proc_code as varchar(100)) as source_code,
    cast(eap.proc_name as varchar(255)) as source_description,
    cast(order_result.component_id as varchar(255)) as source_component,
    cast(null as varchar(100)) as normalized_code_type,
    cast(null as varchar(100)) as normalized_code,
    cast(null as varchar(255)) as normalized_description,
    cast(null as varchar(255)) as normalized_component,
    cast(order_result.result_status_c as varchar(100)) as status,
    cast(order_result.ord_value as varchar(100)) as result,
    cast(order_result.result_time as date) as result_date,
    cast(order_proc_2.specimn_taken_time as date) as collection_date, 
    cast(order_result.reference_unit as varchar(100)) as source_units,
    cast(null as varchar(100)) as normalized_units,
    cast(order_result.reference_low as varchar(100)) as source_reference_range_low,
    cast(order_result.reference_high as varchar(100)) as source_reference_range_high,
    cast(null as varchar(100)) as normalized_reference_range_low,
    cast(null as varchar(100)) as normalized_reference_range_high,
    cast(case when order_result.result_in_range_yn = 'N' then 1 else 0 end as int) as source_abnormal_flag,
    cast(null as int) as normalized_abnormal_flag,
    cast(null as varchar(100)) as specimen,
    cast(order_proc.authrzing_prov_id as varchar(50)) as ordering_practitioner_id,
    cast(null as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'order_proc') }} as order_proc
inner join {{ source('epic', 'order_proc_2') }} as order_proc_2
    on order_proc.order_proc_id = order_proc_2.order_proc_id
left join {{ source('epic', 'order_results') }} as order_result
    on order_proc.order_proc_id = order_result.order_proc_id
left join {{ source('epic', 'clarity_eap') }} as eap
    on order_proc.proc_id = eap.proc_id