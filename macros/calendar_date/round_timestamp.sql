{% macro round_timestamp(timestamp) %}
    {{ date_trunc("day", dateadd("hour", 12, timestamp)) }}
{% endmacro %}
