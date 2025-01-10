-- Return records where number_of_orders is not greater than 0
select
    customer_id,
    number_of_orders
from {{ ref('top_customers') }}
where number_of_orders <= 0