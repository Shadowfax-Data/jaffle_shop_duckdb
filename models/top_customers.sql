SELECT 
    customer_id,
    COUNT(*) as number_of_orders
FROM {{ ref('orders') }}
GROUP BY customer_id
ORDER BY number_of_orders DESC