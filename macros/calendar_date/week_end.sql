{%- macro week_end(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('week_end', packages = dbt_date._get_utils_namespaces()) (dt) }}
{%- endmacro -%}

{%- macro default__week_end(date) -%}
{{ dbt_utils.last_day(date, 'week') }}
{%- endmacro %}

{%- macro snowflake__week_end(date) -%}
{%- set dt = dbt_date.week_start(date) -%}
{{ dbt_date.n_days_away(6, dt) }}
{%- endmacro %}

{%- macro postgres__week_end(date) -%}
{%- set dt = dbt_date.week_start(date) -%}
{{ dbt_date.n_days_away(6, dt) }}
{%- endmacro %}

{%- macro sqlserver__week_end(date) -%}
{%- set dt = dbt_date.week_start(date) -%}
{{ dbt_date.n_days_away(6, dt) }}
{%- endmacro %}