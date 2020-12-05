{%- macro day_of_week(date, isoweek=true) -%}
{{ adapter.dispatch('day_of_week', packages = dbt_date._get_utils_namespaces()) (date, isoweek) }}
{%- endmacro %}

{%- macro default__day_of_week(date, isoweek) -%}
{%- set dow = dbt_date.date_part('dayofweek', 'd.date_day') -%}
{%- if isoweek -%}
case
    -- Shift start of week to Monday
    when {{ dow }} = 0 then 7
    else {{ dow }}
end
{%- else -%}
{{ dow }}
{%- endif -%}
{%- endmacro %}


