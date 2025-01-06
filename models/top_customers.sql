{#-
  This model identifies and ranks customers based on their order frequency.
  It aggregates the total number of orders placed by each customer,
  providing insights into customer purchasing behavior and helping identify
  the most active customers in terms of order volume.
#}

select
    customer_id,
    count(*) as number_of_orders
from {{ ref('orders') }}
group by customer_id
order by number_of_orders desc