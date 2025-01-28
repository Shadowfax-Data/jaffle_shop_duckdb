-- Test to ensure total_order_amount is not negative
select
    customer_id,
    customer_lifetime_value
from {{ ref('customers') }}
where customer_lifetime_value < 0