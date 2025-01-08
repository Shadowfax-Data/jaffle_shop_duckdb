/*
    This model identifies and ranks customers based on their order volume.
    It aggregates the total number of orders placed by each customer,
    providing a clear view of the most active customers in terms of 
    order frequency. The results are sorted in descending order,
    with the highest volume customers appearing first.
*/

select
    customer_id,  -- Unique identifier for each customer
    count(*) as number_of_orders  -- Total count of orders placed by the customer
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc