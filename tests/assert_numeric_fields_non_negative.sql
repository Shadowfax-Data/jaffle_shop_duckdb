-- Test that number_of_orders and customer_lifetime_value are non-negative
select
    customer_id,
    number_of_orders,
    customer_lifetime_value
from {{ ref('customers') }}
where number_of_orders < 0
   or customer_lifetime_value < 0