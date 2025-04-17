select 
    problem_list_id, -- internal id for the problem list
    pat_id, -- internal id for the patient
    problem_status_c, -- 1 = active, 2 = inactive, 3 = resolved
    date_of_entry, -- date the problem was entered
    noted_date, -- date the problem was noted
    resolved_date, -- date the problem was resolved
    dx_id -- internal id for the diagnosis
from {{ source('epic','problem_list') }}