select
    customer_id,
    first_order,
    most_recent_order
from {{ ref('customers') }}
where most_recent_order < first_order