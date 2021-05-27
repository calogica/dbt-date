{%- macro day_of_month(date) -%}
cast({{ dbt_date.date_part('day', date) }} as {{ dbt_utils.type_int() }})
{%- endmacro %}
