{%- macro convert_timezone(column, target_tz=None, source_tz=None) -%}
{%- set source_tz = "UTC" if not source_tz else source_tz -%}
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
{%- if execute and source_tz != "UTC" %}
{{ exceptions.raise_compiler_error("BigQuery does not support converting timestamps from a timezone other than UTC. Got: " ~ source_tz) }}
{% endif -%}
timestamp(datetime({{ column }}, '{{ target_tz}}'))
{%- endmacro -%}

{%- macro spark__convert_timezone(column, target_tz, source_tz) -%}
from_utc_timestamp(
        to_utc_timestamp({{ column }}, '{{ source_tz }}'),
        '{{ target_tz }}'
        )
{%- endmacro -%}

{% macro postgres__convert_timezone(column, target_tz, source_tz) -%}
cast({{ column }} at time zone '{{ source_tz }}' at time zone '{{ target_tz }}' as {{ dbt_utils.type_timestamp() }})
{%- endmacro -%}
