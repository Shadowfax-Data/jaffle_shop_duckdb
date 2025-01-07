/*
    Model: top_customers
    Description: This model identifies and ranks customers based on their order volume,
    calculating the total number of orders placed by each customer. It provides critical
    insights into customer purchasing behavior and engagement levels.

    Business Context:
    - Helps identify our most valuable and engaged customers for targeted marketing
    - Supports customer segmentation and loyalty program initiatives
    - Enables customer success teams to prioritize high-volume customer relationships
    - Provides input for customer retention strategies

    Columns:
    - customer_id (integer): Unique identifier for each customer from the orders table
    - number_of_orders (integer): Total count of orders placed by the customer,
      calculated by counting all order instances per customer

    Usage Examples:
    1. Find top 10 customers by order volume:
       SELECT * FROM {{ target.schema }}.top_customers LIMIT 10

    2. Analyze customers with more than 5 orders:
       SELECT * FROM {{ target.schema }}.top_customers WHERE number_of_orders > 5

    Dependencies:
    - Requires orders table (ref: orders)
*/

select
    customer_id,  -- Unique identifier for each customer
    count(*) as number_of_orders  -- Total count of orders placed by the customer
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc