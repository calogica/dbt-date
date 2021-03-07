
with data as (

    select * from {{ ref('data_day_of_month') }}

)

select
    {{ dbt_date.day_of_month('date_day') }} as actual,
    day as expected

from data
