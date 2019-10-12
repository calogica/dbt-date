{%- macro n_weeks_away(n, tz=None) -%}
{%- set n = n|int -%}
{{ dbt_utils.date_trunc('week', 
    dbt_utils.dateadd('week', n, 
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}