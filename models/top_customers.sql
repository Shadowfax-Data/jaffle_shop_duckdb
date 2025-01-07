{#-
  This model identifies and ranks customers based on their order frequency.
  It provides a clear view of the most active customers by aggregating their total number of orders.

  Columns:
    - customer_id: Unique identifier for each customer
    - number_of_orders: Total count of orders placed by the customer, used for ranking

  Business Context:
    This model helps identify our most engaged customers, which is valuable for:
    - Customer retention analysis
    - Targeted marketing campaigns
    - Understanding purchasing patterns
#}

select
    customer_id,
    count(*) as number_of_orders
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc