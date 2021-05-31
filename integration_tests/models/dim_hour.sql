{{
    config(
        materialized = "table"
    )
}}

select
    *
from
   ({{ dbt_date.get_base_dates(n_dateparts=24*28, datepart="hour") }})
