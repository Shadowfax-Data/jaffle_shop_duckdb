-- Test to ensure number_of_orders is greater than or equal to 0
select
    customer_id,
    number_of_orders
from {{ ref('top_customers') }}
where number_of_orders < 0