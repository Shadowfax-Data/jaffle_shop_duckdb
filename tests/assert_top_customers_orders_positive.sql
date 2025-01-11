/*
    Test Name: Assert Top Customers Orders Are Positive
    
    Purpose:
    This test validates that all customers in the top_customers model have a positive
    number of orders. It ensures data quality and business logic integrity by 
    verifying that no customer has zero or negative orders.
    
    Business Context:
    - The top_customers model represents customer order activity
    - By definition, a customer must have placed at least one order to be considered
    - Zero orders would indicate a data anomaly as such customers shouldn't appear in the model
    - Negative orders are impossible in our business context and would indicate a serious data issue
    
    Test Logic:
    - Queries the top_customers model
    - Looks for any records where number_of_orders is less than or equal to 0
    - These represent violations of our business rules
    
    Expected Behavior:
    - The test should return ZERO rows when all data is valid
    - If any rows are returned, it indicates data quality issues that need investigation
    
    Failing Results Would Indicate:
    - Data pipeline issues affecting order counts
    - Potential bugs in aggregation logic
    - Possible data corruption in source tables
*/

-- Main test query to identify any customers with invalid order counts
select
    -- Include customer_id to identify specific customers failing the validation
    customer_id,
    -- Include number_of_orders to show the actual invalid value for debugging
    number_of_orders
-- Reference the top_customers model which contains our aggregated customer order data
from {{ ref('top_customers') }}
-- Business rule validation: filter for records violating our positive order count requirement
-- A value <= 0 would indicate either:
--   a) 0 orders: invalid as customers must have at least one order to be included
--   b) negative orders: impossible scenario indicating data corruption
where number_of_orders <= 0