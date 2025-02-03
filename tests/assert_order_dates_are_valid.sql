-- Test that first_order is before or equal to most_recent_order when both are not null
select
    customer_id,
    first_order,
    most_recent_order
from {{ ref('customers') }}
where first_order > most_recent_order
  and first_order is not null 
  and most_recent_order is not null