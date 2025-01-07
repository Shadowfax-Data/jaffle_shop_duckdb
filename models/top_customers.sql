{#
  This model identifies top customers based on their order frequency.
  
  Columns:
    - customer_id: Unique identifier for each customer
    - number_of_orders: Total count of orders placed by the customer
    
  Source:
    - Uses the orders model to aggregate order counts per customer
#}

select
    customer_id,
    count(*) as number_of_orders
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc