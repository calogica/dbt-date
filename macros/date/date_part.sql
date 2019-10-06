{% macro date_part(datepart, date) -%}
  {{ adapter_macro('dbt_date.date_part', datepart, date) }}
{%- endmacro %}

{% macro default__date_part(datepart, date) -%}
    date_part('{{ datepart }}', {{  date }})
{%- endmacro %}

{% macro bigquery__date_part(datepart, date) -%}
    extract({{ datepart }} from {{ date }})
{%- endmacro %}
