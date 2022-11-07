{% macro date_from_timestamp(timestamp) %}
    {{ return(adapter.dispatch('date_from_timestamp','dbt_date') (timestamp)) }}
{% endmacro %}

{% macro default__date_from_timestamp(timestamp) %}
    date({{ timestamp }})
{% endmacro %}

{% macro bigquery__date_from_timestamp(timestamp) %}
    cast({{ timestamp }} as date)
{% endmacro %}

{% macro snowflake__date_from_timestamp(timestamp) %}
    to_date(to_timestamp({{ timestamp }}))
{% endmacro %}