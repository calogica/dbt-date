{%- macro day_of_month(date) -%}
{{ dbt_date.date_part('day', date) }}
{%- endmacro %}

