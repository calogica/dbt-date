
with data as (

    select * from {{ ref('data_week_of_year') }}

)

select
    {{ dbt_date.week_of_year('date_day') }} as actual,
    week_of_year as expected

from data
