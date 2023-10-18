{% macro date(year, month, day) %}
    {{ return(modules.datetime.date(year, month, day)) }}
{% endmacro %}

{% macro datetime(year, month, day, hour=0, minute=0, second=0, millisecond=0) %}
    {{ return(modules.datetime.datetime(year, month, day, hour, minute, second, millisecond, modules.pytz.timezone(var("dbt_date:time_zone")))) }}
{% endmacro %}
