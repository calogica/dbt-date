{%- macro iso_week_end(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('iso_week_end', packages = dbt_date._get_utils_namespaces()) (dt) }}
{%- endmacro -%}

{%- macro _iso_week_end(date, week_type) -%}
{%- set dt = dbt_date.iso_week_start(date) -%}
{{ dbt_date.n_days_away(6, dt) }}
{%- endmacro %}

{%- macro default__iso_week_end(date) -%}
{{ dbt_date._iso_week_end(date, 'isoweek') }}
{%- endmacro %}

{%- macro snowflake__iso_week_end(date) -%}
{{ dbt_date._iso_week_end(date, 'weekiso') }}
{%- endmacro %}

{%- macro sqlserver__iso_week_end(date) -%}
{{ dbt_date._iso_week_end(date, 'iso_week') }}
{%- endmacro %}