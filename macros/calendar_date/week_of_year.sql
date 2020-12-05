{%- macro week_of_year(date=None, tz=None) -%}
{%-set dt = date if date else dbt_date.today(tz) -%}
cast({{ dbt_date.date_part('week', dt) }} as {{ dbt_utils.type_int() }}) 
{%- endmacro -%}