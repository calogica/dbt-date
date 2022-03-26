{# 
    Relative datediff can be useful for dateparts more granular than daily.
    For example, consider dbt_utils.datediff('month', "'2021-09-01'", "'2021-10-30'")
    This will return 1, despite there being almost 60 days in between the two.
    This makes analysis quite difficul when you want to work in units like months or quarters,
    but this should be derived from the number of days.

    This macro works by looking at the date of date1, subtracting that (minus one) number of days to date 2
    (which normalises date2 relative to date 1, ie. as if date 1 was the first of a month) and then computes
    the normal date diff.

    TODO: use a date_part from dbt utils (which doesn't exist right now :P) instead of hardcoding the function.
#}
{% macro relative_datediff(date1, date2, datepart) %}
    {{
        dbt_utils.datediff(
            date1,
            dbt_utils.dateadd(
                'day',
                '1 - date_part(day,'~date1~')',
                date2
            ),
            datepart
        )
    }}
{% endmacro %}
