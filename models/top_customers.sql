select
    customer_id,
    count(order_id) as number_of_orders
from {{ ref('stg_orders') }}
group by customer_id
order by number_of_orders desc