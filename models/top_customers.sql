/*
    This model identifies and ranks customers based on their order volume.
    It calculates the total number of orders placed by each customer,
    providing insights into customer purchasing frequency and helping
    identify the most active customers in the system.
*/

select
    customer_id,  -- Unique identifier for each customer
    count(*) as number_of_orders  -- Total count of orders placed by the customer
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc