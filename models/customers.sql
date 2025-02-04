with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('orders') }}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders,
        datediff('day', max(order_date), current_timestamp) as days_since_last_order,
        sum(amount) as total_order_amount
    from orders
    group by customer_id
),

final as (
    select
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        coalesce(customer_orders.first_order, null) as first_order,
        coalesce(customer_orders.most_recent_order, null) as most_recent_order,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        coalesce(customer_orders.days_since_last_order, null) as days_since_last_order,
        coalesce(customer_orders.total_order_amount, 0) as total_order_amount
    from customers
    left join customer_orders
        on customers.customer_id = customer_orders.customer_id
)

select * from final
