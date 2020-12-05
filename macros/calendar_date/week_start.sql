{%- macro week_start(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('week_start', packages = dbt_date._get_utils_namespaces()) (dt) }}
{%- endmacro -%}

{%- macro default__week_start(date) -%}
cast({{ dbt_utils.date_trunc('week', date) }} as date)
{%- endmacro %}

{%- macro snowflake__week_start(date) -%}
case 
    when {{ dbt_date.day_of_week(dbt_utils.date_trunc('week', date), isoweek=False) }} = 1
    then {{ dbt_date.n_days_ago(
            dbt_date.day_of_week(date, isoweek=False) ~ " - 1",
            date
            ) }}
end
{%- endmacro %}