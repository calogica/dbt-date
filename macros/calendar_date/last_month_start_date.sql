{%- macro last_month_start_date(tz=None) -%}
{{ dbt_date.last_month(1, tz) }}
{%- endmacro -%}