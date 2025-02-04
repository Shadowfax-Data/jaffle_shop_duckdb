{% test positive_values(model, column_name, zero_allowed=false) %}

select *
from {{ model }}
where {{ column_name }} {% if zero_allowed %} < 0 {% else %} <= 0 {% endif %}

{% endtest %}