-- Test that most_recent_order is not in the future
select
    customer_id,
    most_recent_order
from {{ ref('customers') }}
where most_recent_order > current_date
  and most_recent_order is not null