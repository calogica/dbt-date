{% macro to_unixtimestamp(timestamp) -%}
  {{ adapter_macro('dbt_date.to_unixtimestamp', timestamp) }}
{%- endmacro %}

{% macro default__to_unixtimestamp(timestamp) -%}
    {{ dbt_date.date_part('epoch_seconds', timestamp) }}
{%- endmacro %}

{% macro bigquery__to_unixtimestamp(timestamp) -%}
    unix_seconds({{ timestamp }})
{%- endmacro %}
