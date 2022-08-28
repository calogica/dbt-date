{%- macro now(tz=None) -%}
{{ dbt_date.convert_timezone(dbt_date.current_timestamp(), tz) }}
{%- endmacro -%}

{% macro current_timestamp() -%}
  {{ return(adapter.dispatch('current_timestamp', 'dbt_date')()) }}
{%- endmacro %}

{% macro default__current_timestamp() %}
    current_timestamp::{{ type_timestamp() }}
{% endmacro %}

{% macro redshift__current_timestamp() %}
    getdate()
{% endmacro %}

{% macro bigquery__current_timestamp() %}
    current_timestamp
{% endmacro %}
