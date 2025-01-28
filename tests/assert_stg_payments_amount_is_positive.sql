-- Return records where amount is negative to make the test fail
select
    payment_id,
    amount
from {{ ref('stg_payments') }}
where amount < 0