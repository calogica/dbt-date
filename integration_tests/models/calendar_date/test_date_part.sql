
with data as (

    select * from {{ ref('data_date_part') }}

)

select
    {{ dbt_date.date_part('day', 'date_day') }} as actual,
    day as expected

from data

union all

select
    {{ dbt_date.date_part('month', 'date_day') }} as actual,
    month as expected

from data

union all

select
    {{ dbt_date.date_part('year', 'date_day') }} as actual,
    year as expected

from data
