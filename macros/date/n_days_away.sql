{%- macro n_days_away(n, tz=None) -%}
{%- set n = n|int -%}
{{ dbt_utils.dateadd('day', 1 * n, dbt_date.today(tz)) }}
{%- endmacro -%}