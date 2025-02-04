select
    customer_id,
    number_of_orders,
    customer_lifetime_value
from {{ ref('customers') }}
where number_of_orders < 0
    or customer_lifetime_value < 0