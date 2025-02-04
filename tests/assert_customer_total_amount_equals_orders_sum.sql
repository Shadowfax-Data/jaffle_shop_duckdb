-- This test validates that the total_order_amount in customers matches the sum of orders
with customer_orders_sum as (
    select 
        customer_id,
        sum(amount) as calculated_total
    from {{ ref('orders') }}
    group by customer_id
)

select
    c.customer_id,
    c.total_order_amount as stored_total,
    cos.calculated_total as sum_from_orders
from {{ ref('customers') }} c
inner join customer_orders_sum cos
    on c.customer_id = cos.customer_id
where abs(c.total_order_amount - cos.calculated_total) > 0.01 -- allowing for small rounding differences