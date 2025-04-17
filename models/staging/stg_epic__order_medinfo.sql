select 
    order_med_id,
    medication_id
from {{ source('epic','order_medinfo') }}