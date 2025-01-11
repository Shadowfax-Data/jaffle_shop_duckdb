/*
    Test to verify that all customers in top_customers have a positive number of orders.
    Customers must have at least one order to be included in the model.
    
    The test fails if it finds any records where number_of_orders <= 0,
    which would indicate invalid data since zero or negative orders are not possible.
*/

select
    customer_id,
    number_of_orders
from {{ ref('top_customers') }}
where number_of_orders <= 0