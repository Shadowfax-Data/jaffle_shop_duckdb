-- This test validates various business rules for customer metrics:
-- 1. first_order and most_recent_order should be null if number_of_orders = 0
-- 2. first_order and most_recent_order should not be null if number_of_orders > 0
-- 3. most_recent_order should be >= first_order when both are not null
-- 4. total_order_amount should be 0 when number_of_orders = 0
-- 5. total_order_amount should be > 0 when number_of_orders > 0

with invalid_customers as (
    select
        customer_id,
        first_order,
        most_recent_order,
        number_of_orders,
        total_order_amount,
        case
            when number_of_orders = 0 and (first_order is not null or most_recent_order is not null)
                then 'Orders = 0 but has order dates'
            when number_of_orders > 0 and (first_order is null or most_recent_order is null)
                then 'Has orders but missing order dates'
            when most_recent_order < first_order
                then 'Most recent order before first order'
            when number_of_orders = 0 and total_order_amount != 0
                then 'No orders but has order amount'
            when number_of_orders > 0 and total_order_amount <= 0
                then 'Has orders but invalid order amount'
            else null
        end as validation_error
    from {{ ref('customers') }}
    where
        (number_of_orders = 0 and (first_order is not null or most_recent_order is not null or total_order_amount != 0))
        or (number_of_orders > 0 and (first_order is null or most_recent_order is null or total_order_amount <= 0))
        or (most_recent_order < first_order)
)

select * from invalid_customers where validation_error is not null