{% macro get_base_dates(start_date=None, end_date=None, n_dateparts=None, datepart="day") %}
    {{ adapter.dispatch('get_base_dates', 'dbt_date') (start_date, end_date, n_dateparts, datepart) }}
{% endmacro %}

{% macro default__get_base_dates(start_date, end_date, n_dateparts, datepart) %}

{%- if start_date and end_date -%}
{%- set start_date="cast('" ~ start_date ~ "' as " ~ dbt_utils.type_timestamp() ~ ")" -%}
{%- set end_date="cast('" ~ end_date ~ "' as " ~ dbt_utils.type_timestamp() ~ ")"  -%}

{%- elif n_dateparts and datepart -%}

{%- set start_date = dbt_utils.dateadd(datepart, -1 * n_dateparts, dbt_date.today()) -%}
{%- set end_date = dbt_date.tomorrow() -%}
{%- endif -%}

with date_spine as
(

    {{ dbt_utils.date_spine(
        datepart=datepart,
        start_date=start_date,
        end_date=end_date,
       )
    }}

)
select
    cast(d.date_{{ datepart }} as {{ dbt_utils.type_timestamp() }}) as date_{{ datepart }}
from
    date_spine d
{% endmacro %}

{% macro bigquery__get_base_dates(start_date, end_date, n_dateparts, datepart) %}

{%- if start_date and end_date -%}
{%- set start_date="cast('" ~ start_date ~ "' as date )" -%}
{%- set end_date="cast('" ~ end_date ~ "' as date )" -%}

{%- elif n_dateparts and datepart -%}

{%- set start_date = dbt_utils.dateadd(datepart, -1 * n_dateparts, dbt_date.today()) -%}
{%- set end_date = dbt_date.tomorrow() -%}
{%- endif -%}

with date_spine as
(

    {{ dbt_utils.date_spine(
        datepart=datepart,
        start_date=start_date,
        end_date=end_date,
       )
    }}

)
select
    cast(d.date_{{ datepart }} as {{ dbt_utils.type_timestamp() }}) as date_{{ datepart }}
from
    date_spine d
{% endmacro %}
