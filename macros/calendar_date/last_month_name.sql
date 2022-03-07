{%- macro last_month_name(short=True, tz=None) -%}
{{ dbt_date.month_name(dbt_date.last_month(1, tz), short=short) }}
{%- endmacro -%}
