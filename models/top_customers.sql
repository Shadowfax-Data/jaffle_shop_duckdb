{# 
  This model identifies and ranks customers based on their order frequency.
  It aggregates order data from stg_orders to calculate the total number of orders
  placed by each customer, providing insights for customer segmentation and 
  analysis of purchasing behavior.

  Output columns:
    - customer_id: Unique identifier for each customer
    - number_of_orders: Total count of orders placed by the customer
#}

SELECT
    customer_id,
    COUNT(*) as number_of_orders  -- Calculate total orders per customer
FROM {{ ref('stg_orders') }}  -- Source from staged orders table
GROUP BY customer_id  -- Aggregate at customer level
ORDER BY number_of_orders DESC  -- Sort to show most frequent customers first