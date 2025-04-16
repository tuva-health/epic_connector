select 
    order_proc_id,
    specimn_taken_time
from {{ source('epic','order_proc_2') }}