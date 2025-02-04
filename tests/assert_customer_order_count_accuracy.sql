with order_counts as (
    select 
        customer_id,
        count(*) as actual_order_count
    from {{ ref('stg_orders') }}
    group by customer_id
)

select
    c.customer_id,
    c.number_of_orders as reported_order_count,
    o.actual_order_count
from {{ ref('customers') }} c
left join order_counts o using (customer_id)
where c.number_of_orders != coalesce(o.actual_order_count, 0)