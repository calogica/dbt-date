{%- macro periods_since(date_col, period_name='day', tz=None) -%}
{{ dbt_utils.datediff(date_col, dbt_date.now(tz), period_name) }}
{%- endmacro -%}
