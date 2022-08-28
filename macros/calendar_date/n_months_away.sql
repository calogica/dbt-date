{%- macro n_months_away(n, tz=None) -%}
{%- set n = n|int -%}
{{ date_trunc('month',
    dateadd('month', n,
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}
