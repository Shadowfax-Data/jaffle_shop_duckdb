WITH customers AS (
    SELECT
        customer_id,
        first_name,
        last_name
    FROM {{ ref('stg_customers') }}
),

orders AS (
    SELECT
        customer_id,
        order_id,
        order_date
    FROM {{ ref('stg_orders') }}
),

payments AS (
    SELECT
        order_id,
        amount
    FROM {{ ref('stg_payments') }}
),

customer_orders AS (
    SELECT
        customer_id,
        MIN(order_date) AS first_order,
        MAX(order_date) AS most_recent_order,
        COUNT(order_id) AS number_of_orders
    FROM orders
    GROUP BY customer_id
),

customer_payments AS (
    SELECT
        orders.customer_id,
        SUM(payments.amount) AS total_amount
    FROM payments
    LEFT JOIN orders ON payments.order_id = orders.order_id
    GROUP BY orders.customer_id
),

final AS (
    SELECT
        customers.customer_id,
        customers.first_name,
        customers.last_name,
        COALESCE(
            customer_orders.first_order,
            '1900-01-01'::TIMESTAMP
        ) AS first_order,
        COALESCE(
            customer_orders.most_recent_order,
            '1900-01-01'::TIMESTAMP
        ) AS most_recent_order,
        COALESCE(
            customer_orders.number_of_orders,
            0
        ) AS number_of_orders,
        COALESCE(
            customer_payments.total_amount,
            0
        ) AS customer_lifetime_value
    FROM customers
    LEFT JOIN customer_orders
        ON customers.customer_id = customer_orders.customer_id
    LEFT JOIN customer_payments
        ON customers.customer_id = customer_payments.customer_id
)

SELECT
    customer_id,
    first_name,
    last_name,
    first_order,
    most_recent_order,
    number_of_orders,
    customer_lifetime_value
FROM final
