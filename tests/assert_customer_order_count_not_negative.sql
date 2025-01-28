-- Test to ensure number_of_orders is not negative
select
    customer_id,
    number_of_orders
from {{ ref('customers') }}
where number_of_orders < 0