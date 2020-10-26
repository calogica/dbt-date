{% macro get_base_dates(start_date=None, end_date=None, n_dateparts=None, datepart=None) %}
with date_spine as
(
    {% if start_date and end_date %}
    {%- set start_date="cast('" ~ start_date ~ "' as datetime)" -%}
    {%- set end_date="cast('" ~ end_date ~ "' as datetime)"  -%}

    {% elif n_dateparts and datepart %}

    {%- set start_date = dbt_utils.dateadd(datepart, -1 * n_dateparts, dbt_date.today()) -%}
    {%- set end_date = dbt_date.tomorrow() -%}
    {% endif %}

    {{ dbt_utils.date_spine(
        datepart="day",
        start_date=start_date,
        end_date=end_date,
       )
    }}

)
select
    date(d.date_day) as date_day
from
    date_spine d
{% endmacro %}