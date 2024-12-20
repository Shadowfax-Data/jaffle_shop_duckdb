-- Test to verify that total_order_amount is always greater than or equal to average_order_value
-- This should always be true since average is total divided by count
select
    customer_id,
    total_order_amount,
    average_order_value
from {{ ref('customer_lifetime_value') }}
where total_order_amount < average_order_value