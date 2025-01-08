{#
    This model identifies top customers based on their order frequency.
    It aggregates data from the orders table to calculate the total number
    of orders placed by each customer.

    Columns:
    - customer_id: Unique identifier for each customer
    - number_of_orders: Total count of orders placed by the customer,
      sorted in descending order to show top customers first
#}

select
    customer_id,
    count(*) as number_of_orders
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc