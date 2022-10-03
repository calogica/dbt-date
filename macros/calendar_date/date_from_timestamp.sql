{% macro get_date_from_timestamp(timestamp) %}
  {{ return(adapter.dispatch('get_date_from_timestamp') (timestamp)) }}
{% endmacro %}

{% macro default__get_date_from_timestamp(timestamp) %}
    date({{timestamp}})
{% endmacro %}

{% macro bigquery__get_date_from_timestamp(timestamp) %}
    cast({{timestamp}} as date)
{% endmacro %}

{% macro snowflake__get_date_from_timestamp(timestamp) %}
    to_date(to_timestamp({{ timestamp }}))
{% endmacro %}