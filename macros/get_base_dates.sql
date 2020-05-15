{% macro get_base_dates(start_date, end_date) %}
with date_spine as
(
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="cast('" ~ start_date ~ "' as datetime)",
        end_date="cast('" ~ end_date ~ "' as datetime)",
       )
    }}
)
select
    d.day_date
from
    date_spine d
{% endmacro %}
