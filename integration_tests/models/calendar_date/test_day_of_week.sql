
with data as (

    select * from {{ ref('data_day_of_week') }}

)

select
    {{ dbt_date.day_of_week('date_day', isoweek=false) }} as actual,
    week as expected

from data

union all

select
    {{ dbt_date.day_of_week('date_day', isoweek=true) }} as actual,
    isoweek as expected

from data
