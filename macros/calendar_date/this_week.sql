{%- macro this_week(date=None, tz=None) -%}
{{ dbt_utils.this_week_start(date, tz) }}
{%- endmacro -%}
