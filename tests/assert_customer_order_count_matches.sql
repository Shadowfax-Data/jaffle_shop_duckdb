-- This test validates that the number_of_orders in customers matches the actual count of orders
with order_counts as (
    select 
        customer_id,
        count(*) as actual_order_count
    from {{ ref('orders') }}
    group by customer_id
)

select
    c.customer_id,
    c.number_of_orders as stored_count,
    oc.actual_order_count as calculated_count
from {{ ref('customers') }} c
inner join order_counts oc
    on c.customer_id = oc.customer_id
where c.number_of_orders != oc.actual_order_count