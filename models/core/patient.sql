select 
    cast(pat_id as varchar(50)) as patient_id,
    cast(pat_id as varchar(50)) as person_id,
    cast(first_name as varchar(255)) as first_name,
    cast(last_name as varchar(255)) as last_name,
    cast(sex_c as varchar(100)) as sex,
    cast(race_c as varchar(100)) as race,
    cast(birth_date as date) as birth_date,
    cast(death_date as date) as death_date,
    cast(case when death_date is not null then 1 else 0 end as int) as death_flag,
    cast(ssn as varchar(100)) as social_security_number,
    cast(add_line_1 || ' ' || coalesce(add_line_2, '') as varchar(255)) as address,
    cast(city as varchar(100)) as city,
    cast(state_c as varchar(100)) as state,
    cast(zip as varchar(100)) as zip_code,
    cast(county_c as varchar(100)) as county, 
    cast(null as float) as latitude,
    cast(null as float) as longitude,
    cast(home_phone as varchar(100)) as phone,
    cast('epic' as varchar(100)) as data_source,
    cast(null as varchar(255)) as file_name,
    cast(null as datetime) as ingest_datetime
from {{ source('epic', 'patient') }}