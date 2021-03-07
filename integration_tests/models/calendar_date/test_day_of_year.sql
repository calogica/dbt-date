
with data as (

    select * from {{ ref('data_day_of_year') }}

)

select
    {{ dbt_date.day_of_year('date_day') }} as actual,
    year as expected

from data
