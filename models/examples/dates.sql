{{
    config(
        materialized = 'table'
    )
}}
with date_dimension as (
    {{ dbt_date.get_date_dimension('2015-01-01', '2022-12-31') }}
)
select
    d.*
from
    date_dimension d