{%- macro next_week_start_date(tz=None) -%}
{{ dbt_date.next_week(1, tz) }}
{%- endmacro -%}