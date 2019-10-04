{%- macro n_months_away(n, tz=None) -%}
{%- set n = n|int -%}
{{ dbt_utils.date_trunc('month', 
    dbt_utils.dateadd('month', n, 
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}