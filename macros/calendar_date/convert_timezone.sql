{%- macro convert_timezone(column, target_tz=None, source_tz=None) -%}
{%- set target_tz = var("dbt_date:time_zone") if not target_tz else target_tz -%}
{{ adapter.dispatch('convert_timezone', packages = dbt_date._get_utils_namespaces()) (column, target_tz, source_tz) }}
{%- endmacro -%}

{% macro default__convert_timezone(column, target_tz, source_tz) -%}
    {%- if not source_tz -%}
    cast(convert_timezone('{{ target_tz }}', {{ column }}) as {{ dbt_utils.type_timestamp() }})
    {%- else -%}
    cast(convert_timezone('{{ source_tz }}', '{{ target_tz }}', {{ column }}) as {{ dbt_utils.type_timestamp() }})
    {%- endif -%}
{%- endmacro -%}

{%- macro bigquery__convert_timezone(column, target_tz, source_tz=None) -%}
    timestamp(datetime({{ column }}, '{{ target_tz}}'))
{%- endmacro -%}
