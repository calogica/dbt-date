
with data as (

    select * from {{ ref('data_week_start') }}

)

select
    {{ dbt_date.week_start('date_day') }} as actual,
    week_start_date as expected

from data
