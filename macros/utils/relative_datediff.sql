{% macro relative_datediff(date1, date2, datepart) %}
    {{
        dbt_utils.datediff(
            date1,
            dbt_utils.dateadd(
                'day',
                '1 - ' ~ dbt_date.date_part('day',date1),
                date2
            ),
            datepart
        )
    }}
{% endmacro %}
