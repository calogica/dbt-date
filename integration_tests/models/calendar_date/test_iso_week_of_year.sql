
with data as (

    select * from {{ ref('data_iso_week_of_year') }}

)

select
    {{ dbt_date.iso_week_of_year('date_day') }} as actual,
    iso_week_of_year as expected

from data
