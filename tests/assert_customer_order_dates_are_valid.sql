-- Test to ensure most_recent_order is not earlier than first_order
select
    customer_id,
    first_order,
    most_recent_order
from {{ ref('customers') }}
where most_recent_order < first_order