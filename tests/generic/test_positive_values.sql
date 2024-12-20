{% test positive_values(model, expression) %}

with validation as (
    select *
    from {{ model }}
    where {{ expression }}
)

select *
from validation

{% endtest %}