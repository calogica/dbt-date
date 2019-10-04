{% macro convert_timezone(column, target_tz=None, source_tz=None) %}
{%- set target_tz = var("dbt_extend:time_zone") if not target_tz else target_tz -%}
{{ adapter_macro('dbt_extend.convert_timezone', column, target_tz, source_tz) }}
{% endmacro %}

{% macro default__convert_timezone(column, target_tz=None, source_tz=None) %}
    {%- if not source_tz -%}
    cast(convert_timezone('{{ target_tz }}', {{ column }}) as {{ dbt_utils.type_timestamp() }})
    {%- else -%}
    cast(convert_timezone('{{ source_tz }}', '{{ target_tz }}', {{ column }}) as {{ dbt_utils.type_timestamp() }})
    {%- endif -%}
{% endmacro %}

{% macro bigquery__convert_timezone(column, target_tz=None, source_tz=None) %}
    datetime({{ column }}, '{{ target_tz}}')
{% endmacro %}
