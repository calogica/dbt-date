{%- macro next_month_name(short=True, tz=None) -%}
{{ dbt_date.month_name(dbt_date.next_month(1, tz), short=short) }}
{%- endmacro -%}