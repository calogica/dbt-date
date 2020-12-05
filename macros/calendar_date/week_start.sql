{%- macro week_start(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
cast({{ dbt_utils.date_trunc('week', dt) }} as date)
{%- endmacro -%}