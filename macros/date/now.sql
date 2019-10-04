{%- macro now(tz=None) -%}
{{ dbt_date.convert_timezone(dbt_utils.current_timestamp(), tz) }}
{%- endmacro -%}