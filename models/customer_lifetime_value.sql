with orders as (

    select * from {{ ref('stg_orders') }}

),

payments as (

    select * from {{ ref('stg_payments') }}

),

customer_payments as (

    select
        orders.customer_id,
        sum(payments.amount) as total_order_amount,
        count(distinct orders.order_id) as number_of_orders,
        sum(payments.amount) / nullif(count(distinct orders.order_id), 0) as average_order_value

    from orders

    inner join payments on
         orders.order_id = payments.order_id

    group by orders.customer_id

)

select
    customer_id,
    total_order_amount,
    average_order_value

from customer_payments