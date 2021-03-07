
with data as (

    select * from {{ ref('data_week_end') }}

)

select
    {{ dbt_date.week_end('date_day') }} as actual,
    week_end_date as expected

from data
