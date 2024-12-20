with customer_orders as (
    select
        o.customer_id,
        count(distinct o.order_id) as number_of_orders,
        sum(coalesce(p.amount, 0)) as total_order_amount
    from {{ ref('stg_orders') }} o
    left join {{ ref('stg_payments') }} p
        on o.order_id = p.order_id
    group by 1
)

select
    c.customer_id,
    coalesce(co.total_order_amount, 0) as total_order_amount,
    case 
        when co.number_of_orders > 0 
        then co.total_order_amount / co.number_of_orders 
        else 0 
    end as average_order_value
from {{ ref('stg_customers') }} c
left join customer_orders co
    on c.customer_id = co.customer_id