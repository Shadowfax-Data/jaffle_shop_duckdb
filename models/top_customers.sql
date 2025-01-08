-- This model identifies the most active customers based on their total number of orders
-- It ranks customers by their order count in descending order to highlight top customers

select
    customer_id,
    count(*) as number_of_orders  -- Count total orders per customer
from {{ ref('orders') }}  -- Source from orders table which contains all customer order records
group by customer_id  -- Group records by customer to get per-customer aggregates
order by number_of_orders desc  -- Sort by order count descending to show most active customers first