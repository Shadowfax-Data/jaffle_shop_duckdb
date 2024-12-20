-- Return records where total_order_amount is NULL when it should be 0 for customers without orders
-- This helps ensure our COALESCE handling is working correctly
select
    customer_id,
    total_order_amount
from {{ ref('customer_lifetime_value') }}
where total_order_amount is null