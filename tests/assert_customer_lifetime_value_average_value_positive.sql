-- Return records where:
-- 1. average_order_value is not NULL but customer has no orders (should be NULL)
-- 2. average_order_value is NULL but customer has orders (should have a value)
with customer_orders as (
    select 
        customer_id,
        count(*) as order_count
    from {{ ref('stg_orders') }}
    group by 1
)
select
    c.customer_id,
    c.average_order_value,
    o.order_count
from {{ ref('customer_lifetime_value') }} c
left join customer_orders o using (customer_id)
where (c.average_order_value is not null and o.order_count = 0)
   or (c.average_order_value is null and o.order_count > 0)