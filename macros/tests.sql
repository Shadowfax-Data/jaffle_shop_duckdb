{% test assert_customer_order_dates_are_valid(model) %}

select *
from {{ model }}
where most_recent_order < first_order
  and most_recent_order is not null
  and first_order is not null

{% endtest %}

{% test assert_customer_total_amount_equals_orders(model) %}

with customer_orders as (
    select
        customer_id,
        sum(amount) as calculated_total
    from {{ ref('orders') }}
    group by 1
)

select
    c.customer_id,
    c.customer_lifetime_value as stored_total,
    co.calculated_total,
    abs(c.customer_lifetime_value - co.calculated_total) as difference
from {{ model }} c
left join customer_orders co on c.customer_id = co.customer_id
where (
    -- Case 1: Customer has orders but amounts don't match
    (c.customer_lifetime_value is not null and co.calculated_total is not null and
     abs(c.customer_lifetime_value - co.calculated_total) > 0.01)
    -- Case 2: Customer has no orders but lifetime value is not null
    or (co.calculated_total is null and c.customer_lifetime_value is not null)
    -- Case 3: Customer has orders but lifetime value is null
    or (co.calculated_total is not null and c.customer_lifetime_value is null)
)

{% endtest %}