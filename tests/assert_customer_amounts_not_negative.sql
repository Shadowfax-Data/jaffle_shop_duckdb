-- Return records where total_order_amount or average_order_value are negative
select
    customer_id,
    total_order_amount,
    average_order_value
from {{ ref('customer_lifetime_value') }}
where total_order_amount < 0
    or average_order_value < 0