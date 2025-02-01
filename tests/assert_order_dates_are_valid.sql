-- Test to ensure first_order date is not after most_recent_order date
select *
from {{ ref('customers') }}
where first_order > most_recent_order