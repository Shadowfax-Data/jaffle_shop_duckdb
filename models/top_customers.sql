select
    customer_id,
    count(*) as number_of_orders
from {{ ref('stg_orders') }}
group by customer_id
order by number_of_orders desc