-- Return records where number_of_orders is negative, which would make the test fail
select
    customer_id,
    number_of_orders
from {{ ref('top_customers') }}
where number_of_orders < 0