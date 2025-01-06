{#-
This model identifies and ranks customers based on their order frequency.
It helps in:
- Identifying our most valuable customers by order volume
- Understanding customer engagement patterns
- Supporting customer segmentation initiatives
#}

select
    customer_id,
    count(*) as number_of_orders  -- Aggregating total number of orders per customer
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc    -- Ranking customers from highest to lowest order count