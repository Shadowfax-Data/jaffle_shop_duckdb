-- Test to verify total_order_amount is positive
select *
from {{ ref('customer_lifetime_value') }}
where total_order_amount <= 0
    or total_order_amount is null