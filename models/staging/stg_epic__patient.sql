select 
    pat_id,
    first_name,
    last_name,
    birth_date,
    death_date,
    sex_c,
    ssn,
    add_line_1,
    add_line_2,
    city,
    state_c,
    zip,
    county_c,
    home_phone
from {{ source('epic','patient') }}