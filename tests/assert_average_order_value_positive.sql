-- Test to verify that average_order_value is always greater than zero
-- Since we're dealing with sales data, average order value should never be zero or negative
select
    customer_id,
    average_order_value
from {{ ref('customer_lifetime_value') }}
where average_order_value <= 0