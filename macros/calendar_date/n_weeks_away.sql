{%- macro n_weeks_away(n, tz=None) -%}
{%- set n = n|int -%}
{{ date_trunc('week',
    dateadd('week', n,
        dbt_date.today(tz)
        )
    ) }}
{%- endmacro -%}
