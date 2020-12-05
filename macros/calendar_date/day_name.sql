{%- macro day_name(date, short=True) -%}
    {{ adapter.dispatch('day_name', packages = dbt_date._get_utils_namespaces()) (date, short) }}
{%- endmacro %}

{%- macro default__day_name(date, short) -%}
{%- set f = 'Dy' if short else 'Day' -%}
    to_char({{ date }}, '{{ f }}')
{%- endmacro %}

{%- macro snowflake__day_name(date, short) -%}
    {%- if short -%}
    dayname({{ date }})
    {%- else -%}
    -- long version not implemented on Snowflake so we're doing it manually :/
    case {{ dbt_date.day_of_week(date) }}
        when 1 then 'Monday'
        when 2 then 'Tuesday'
        when 3 then 'Wednesday'
        when 4 then 'Thursday'
        when 5 then 'Friday'
        when 6 then 'Saturday'
        when 7 then 'Sunday'
    end
    {%- endif -%}
    
{%- endmacro %}

{%- macro bigquery__day_name(date, short) -%}
{%- set f = '%a' if short else '%A' -%}
    format_date('{{ f }}', cast({{ date }} as date))
{%- endmacro %}
