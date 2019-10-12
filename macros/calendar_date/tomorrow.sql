{%- macro tomorrow(tz=None) -%}
{{ dbt_utils.dateadd('day', 1, dbt_date.today(tz)) }}
{%- endmacro -%}
