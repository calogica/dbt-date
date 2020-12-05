{%- macro next_month_start_date(tz=None) -%}
{{ dbt_date.next_month(1, tz) }}
{%- endmacro -%}