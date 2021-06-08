{%- macro week_start(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ adapter.dispatch('week_start', 'dbt_date') (dt) }}
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

{%- macro postgres__week_start(date) -%}
-- Sunday as week start date
cast({{ dbt_utils.dateadd('day', -1, dbt_utils.date_trunc('week', dbt_utils.dateadd('day', 1, date))) }} as date)
{%- endmacro %}
