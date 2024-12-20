-- Test to ensure total_order_amount and average_order_value are not negative
select
    customer_id,
    total_order_amount,
    average_order_value
from {{ ref('customer_lifetime_value') }}
where total_order_amount < 0
    or average_order_value < 0