-- Get the total number of orders for each customer, sorted by highest order count
select
    -- Unique identifier for each customer
    customer_id,
    -- Calculate total number of orders by counting all rows per customer
    count(*) as number_of_orders
-- Reference the orders table using dbt's ref function
from {{ ref('orders') }}
-- Group results by customer to get per-customer aggregates
group by customer_id
-- Sort by order count in descending order to show customers with most orders first
order by number_of_orders desc