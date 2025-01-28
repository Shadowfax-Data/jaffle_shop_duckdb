with monthly_customer_spend as (
    select
        date_trunc('month', o.order_date) as month,
        c.customer_id,
        c.first_name,
        c.last_name,
        sum(p.amount) as total_amount
    from {{ ref('stg_customers') }} c
    inner join {{ ref('stg_orders') }} o
        on c.customer_id = o.customer_id
    inner join {{ ref('stg_payments') }} p
        on o.order_id = p.order_id
    where o.status = 'completed'
    group by 1, 2, 3, 4
),

ranked_spenders as (
    select
        month,
        customer_id,
        first_name,
        last_name,
        total_amount,
        row_number() over (partition by month order by total_amount desc) as spend_rank
    from monthly_customer_spend
)

select
    month,
    customer_id,
    first_name,
    last_name,
    total_amount as monthly_spend
from ranked_spenders
where spend_rank = 1
order by month desc