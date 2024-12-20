with order_payments as (
    select
        o.customer_id,
        o.order_id,
        sum(p.amount) as order_amount
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_payments') }} p
        on o.order_id = p.order_id
    group by 1, 2
),

customer_orders as (
    select
        customer_id,
        sum(order_amount) as total_order_amount,
        avg(order_amount) as average_order_value
    from order_payments
    group by 1
)

select
    customer_id,
    total_order_amount,
    average_order_value
from customer_orders