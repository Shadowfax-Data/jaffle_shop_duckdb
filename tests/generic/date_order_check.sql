{% test date_order_check(model, first_date, second_date) %}

select *
from {{ model }}
where {{ first_date }} > {{ second_date }}

{% endtest %}