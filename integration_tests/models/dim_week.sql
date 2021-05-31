{{
    config(
        materialized = "table"
    )
}}

select
    *
from
    ( {{ dbt_date.get_base_dates(n_dateparts=52, datepart="week") }} )
