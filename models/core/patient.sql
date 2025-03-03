select 
    cast(p.pat_id as varchar(50)) as patient_id,
    cast(p.pat_id as varchar(50)) as person_id,
    cast(p.first_name as varchar(255)) as first_name,
    cast(p.last_name as varchar(255)) as last_name,
    cast(zse.name as varchar(100)) as sex,
    cast(zp.name as varchar(100)) as race,
    cast(p.birth_date as date) as birth_date,
    cast(p.death_date as date) as death_date,
    cast(case when p.death_date is not null then 1 else 0 end as int) as death_flag,
    cast(p.ssn as varchar(100)) as social_security_number,
    cast(p.add_line_1 || ' ' || coalesce(p.add_line_2, '') as varchar(255)) as address,
    cast(p.city as varchar(100)) as city,
    cast(zst.name as varchar(100)) as state,
    cast(zip as varchar(100)) as zip_code,
    cast(zco.name as varchar(100)) as county, 
    cast(null as float) as latitude,
    cast(null as float) as longitude,
    cast(p.home_phone as varchar(100)) as phone,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'patient') }} p
    left join {{ source('epic', 'patient_race') }} pr 
    on pr.pat_id = p.pat_id 
    and pr.line = 1
    left join {{ source('epic', 'zc_sex') }} zse 
    on zse.sex_c = p.sex_c 
    left join {{ source('epic', 'zc_state') }} zst 
    on zst.state_c = p.state_c 
    left join {{ source('epic', 'zc_county') }} zco
    on zco.county_c = p.county_c 
    left join {{ source('epic', 'zc_patient_race') }} zp
    on zp.patient_race_c = pr.patient_race_c 