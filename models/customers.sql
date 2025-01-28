with customer_orders as (
    select
        customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(*) as number_of_orders
    from {{ ref('stg_orders') }}
    group by customer_id
),

customer_payments as (
    select
        o.customer_id,
        sum(p.amount) as total_order_amount
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_payments') }} p on o.order_id = p.order_id
    group by o.customer_id
)

select
    c.customer_id,
    c.first_name,
    c.last_name,
    coalesce(o.first_order, null) as first_order,
    coalesce(o.most_recent_order, null) as most_recent_order,
    coalesce(o.number_of_orders, 0) as number_of_orders,
    coalesce(p.total_order_amount, 0) as total_order_amount
from {{ ref('stg_customers') }} c
left join customer_orders o on c.customer_id = o.customer_id
left join customer_payments p on c.customer_id = p.customer_id
