with order_counts as (
    select 
        customer_id,
        count(*) as number_of_orders
    from {{ ref('orders') }}
    group by customer_id
)

select 
    customer_id,
    number_of_orders
from order_counts
order by number_of_orders desc