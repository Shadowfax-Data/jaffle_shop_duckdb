{{
    config(
        materialized='table'
    )
}}

select
    customer_id,
    number_of_orders
from {{ ref('customers') }}
order by number_of_orders desc, customer_id asc