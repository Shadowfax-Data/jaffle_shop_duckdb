{% test assert_dates_ordered(model, column_name, compare_to) %}

select *
from {{ model }}
where {{ column_name }} > {{ compare_to }}
  and {{ column_name }} is not null
  and {{ compare_to }} is not null

{% endtest %}