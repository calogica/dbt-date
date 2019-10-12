{%- macro n_weeks_ago(n, tz=None) -%}
{%- set n = n|int -%}
{{ dbt_utils.date_trunc('week', 
    dbt_utils.dateadd('week', -1 * n, 
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}