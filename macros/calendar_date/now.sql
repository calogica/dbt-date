{%- macro now(tz=None) -%}
{{ dbt_date.convert_timezone(current_timestamp(), tz) }}
{%- endmacro -%}
