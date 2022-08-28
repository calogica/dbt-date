{%- macro n_weeks_ago(n, tz=None) -%}
{%- set n = n|int -%}
{{ date_trunc('week',
    dateadd('week', -1 * n,
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}
