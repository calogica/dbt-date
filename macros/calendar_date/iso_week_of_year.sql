{%- macro iso_week_of_year(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('iso_week_of_year', packages = dbt_date._get_utils_namespaces()) (dt) }}
{%- endmacro -%}

{%- macro _iso_week_of_year(date, week_type) -%}
cast({{ dbt_date.date_part(week_type, date) }} as {{ dbt_utils.type_int() }}) 
{%- endmacro %}

{%- macro default__iso_week_of_year(date) -%}
{{ dbt_date._iso_week_of_year(date, 'isoweek') }}
{%- endmacro %}

{%- macro snowflake__iso_week_of_year(date) -%}
{{ dbt_date._iso_week_of_year(date, 'weekiso') }}
{%- endmacro %}

