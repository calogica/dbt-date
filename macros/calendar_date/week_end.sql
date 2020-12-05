{%- macro week_end(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
{{ dbt_utils.last_day(dt, 'week') }}
{%- endmacro -%}
