with orders as (

    select * from {{ ref('stg_orders') }}

),

customer_orders as (

    select
        customer_id,
        count(order_id) as number_of_orders
    from orders
    group by customer_id

)

select
    customer_id,
    number_of_orders
from customer_orders
order by number_of_orders desc