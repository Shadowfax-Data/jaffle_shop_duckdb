with customers as (
    select * from {{ ref('stg_customers') }}
),

orders as (
    select * from {{ ref('stg_orders') }}
),

payments as (
    select * from {{ ref('stg_payments') }}
),

customer_orders as (
    select
        customer_id,
        min(order_date) as first_order,
        max(order_date) as most_recent_order,
        count(order_id) as number_of_orders
    from orders
    group by customer_id
),

customer_payments as (
    select
        orders.customer_id,
        sum(amount) as total_amount
    from payments
    left join orders using (order_id)
    group by orders.customer_id
),

final as (
    select
        -- Customer information
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        
        -- Order related metrics
        customer_orders.first_order,
        customer_orders.most_recent_order,
        coalesce(customer_orders.number_of_orders, 0) as number_of_orders,
        
        -- Financial metrics
        coalesce(customer_payments.total_amount, 0) as customer_lifetime_value
    from customers
    left join customer_orders using (customer_id)
    left join customer_payments using (customer_id)
)

select * from final
