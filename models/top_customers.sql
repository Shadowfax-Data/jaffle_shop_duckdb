with orders as (

    select * from {{ ref('stg_orders') }}

),

customer_orders as (

    select
        customer_id,
        count(order_id) as number_of_orders
    from orders
    group by customer_id
    order by number_of_orders desc

)

select * from customer_orders