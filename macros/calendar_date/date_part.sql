{% macro date_part(datepart, date) -%}
    {{ adapter.dispatch('date_part', packages = dbt_date._get_utils_namespaces()) (datepart, date) }}
{%- endmacro %}

{% macro default__date_part(datepart, date) -%}
    date_part('{{ datepart }}', {{  date }})
{%- endmacro %}

{% macro bigquery__date_part(datepart, date) -%}
    extract({{ datepart }} from {{ date }})
{%- endmacro %}

{% macro sqlserver__date_part(datepart, date) -%}
    datepart({{ datepart }}, {{ date }})
{%- endmacro %}