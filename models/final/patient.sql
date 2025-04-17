select 
    cast(p.pat_id as {{ dbt.type_string() }}) as patient_id,
    cast(p.pat_id as {{ dbt.type_string() }}) as person_id,
    cast(p.first_name as {{ dbt.type_string() }}) as first_name,
    cast(p.last_name as {{ dbt.type_string() }}) as last_name,
    cast(zse.name as {{ dbt.type_string() }}) as sex,
    cast(zp.name as {{ dbt.type_string() }}) as race,
    cast(p.birth_date as date) as birth_date,
    cast(p.death_date as date) as death_date,
    cast(case when p.death_date is not null then 1 else 0 end as {{ dbt.type_int() }}) as death_flag,
    cast(p.ssn as {{ dbt.type_string() }}) as social_security_number,
    cast(p.add_line_1 || ' ' || coalesce(p.add_line_2, '') as {{ dbt.type_string() }}) as address,
    cast(p.city as {{ dbt.type_string() }}) as city,
    cast(zst.name as {{ dbt.type_string() }}) as state,
    cast(p.zip as {{ dbt.type_string() }}) as zip_code,
    cast(zco.name as {{ dbt.type_string() }}) as county, 
    cast(null as float) as latitude,
    cast(null as float) as longitude,
    cast(p.home_phone as {{ dbt.type_string() }}) as phone,
    cast('epic' as {{ dbt.type_string() }}) as data_source,
    cast(null as {{ dbt.type_string() }}) as file_name,
    cast(null as {{ dbt.type_timestamp() }}) as ingest_datetime
from {{ ref('stg_epic__patient') }} p
    left join {{ ref('stg_epic__patient_race') }} pr 
    on pr.pat_id = p.pat_id 
    and pr.line = 1
    left join {{ ref('stg_epic__zc_sex') }} zse 
    on zse.sex_c = p.sex_c 
    left join {{ ref('stg_epic__zc_state') }} zst 
    on zst.state_c = p.state_c 
    left join {{ ref('stg_epic__zc_county') }} zco
    on zco.county_c = p.county_c 
    left join {{ ref('stg_epic__zc_patient_race') }} zp
    on zp.patient_race_c = pr.patient_race_c 