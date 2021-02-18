{%- macro iso_week_start(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('iso_week_start', packages = dbt_date._get_utils_namespaces()) (dt) }}
{%- endmacro -%}

{%- macro _iso_week_start(date, week_type) -%}
cast({{ dbt_utils.date_trunc(week_type, date) }} as date)
{%- endmacro %}

{%- macro default__iso_week_start(date) -%}
{{ dbt_date._iso_week_start(date, 'week') }}
{%- endmacro %}

{%- macro snowflake__iso_week_start(date) -%}
{{ dbt_date._iso_week_start(date, 'week') }}
{%- endmacro %}

