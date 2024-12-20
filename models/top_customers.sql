select
    customer_id,
    coalesce(number_of_orders, 0) as number_of_orders
from {{ ref('customers') }}
order by number_of_orders desc