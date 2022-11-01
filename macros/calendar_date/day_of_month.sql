{%- macro day_of_month(date) -%}
{{ dbt_date.date_part('day', date) }}
{%- endmacro %}

{%- macro redshift__day_of_month(date) -%}
cast({{ dbt_date.date_part('day', date) }} as {{ type_bigint() }})
{%- endmacro %}
