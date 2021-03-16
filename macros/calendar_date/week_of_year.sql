{%- macro week_of_year(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('week_of_year', packages = dbt_date._get_utils_namespaces()) (dt) }}
{%- endmacro -%}

{%- macro default__week_of_year(date) -%}
cast({{ dbt_date.date_part('week', date) }} as {{ dbt_utils.type_int() }})
{%- endmacro %}

{%- macro postgres__week_of_year(date) -%}
{# postgresql 'week' returns isoweek. Use to_char instead.
   WW = the first week starts on the first day of the year #}
cast(to_char({{ date }}, 'WW') as {{ dbt_utils.type_int() }})
{%- endmacro %}

{%- macro sqlserver__week_of_year(date) -%}
cast({{ dbt_date.date_part('week', dbt_utils.dateadd('day',-1,date)) }} as {{ dbt_utils.type_int() }})
{%- endmacro %}
