{%- macro this_week(tz=None) -%}
{{ dbt_utils.date_trunc('week', dbt_date.today(tz)) }}
{%- endmacro -%}