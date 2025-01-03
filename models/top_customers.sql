SELECT
    customer_id,
    COUNT(order_id) as number_of_orders
FROM {{ ref('stg_orders') }}
GROUP BY customer_id
ORDER BY number_of_orders DESC