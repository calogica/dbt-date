{% macro round_timestamp(field) %}
    {{ dbt_utils.date_trunc("day", dbt_utils.dateadd("'hour'", "12", field)) }}
{% endmacro %}
