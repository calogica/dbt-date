{%- macro n_months_ago(n, tz=None) -%}
{%- set n = n|int -%}
{{ date_trunc('month',
    dateadd('month', -1 * n,
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}
