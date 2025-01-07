{{
    config(
        materialized='table'
    )
}}

/*
    This model identifies top customers based on their total number of orders.
    It provides a simple ranking of customers by order count, which can be used
    to analyze customer engagement and identify the most active customers.
*/

select
    customer_id,
    count(*) as number_of_orders
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc