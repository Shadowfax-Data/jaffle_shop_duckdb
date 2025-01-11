-- Ranks customers by their total number of orders
select
    customer_id,
    count(*) as number_of_orders
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc