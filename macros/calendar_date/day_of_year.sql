{%- macro day_of_year(date) -%}
{{ adapter.dispatch('day_of_year', packages = dbt_date._get_utils_namespaces()) (date) }}
{%- endmacro %}

{%- macro default__day_of_year(date) -%}
    {{ dbt_date.date_part('dayofyear', date) }}
{%- endmacro %}


