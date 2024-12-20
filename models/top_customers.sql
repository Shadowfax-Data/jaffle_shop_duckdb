select
    cast(customer_id as integer) as customer_id,
    coalesce(count(*), 0) as number_of_orders
from {{ ref('stg_orders') }}
group by customer_id
order by number_of_orders desc