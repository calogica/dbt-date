
with data as (

    select * from {{ ref('data_iso_week_end') }}

)

select
    {{ dbt_date.iso_week_end('date_day') }} as actual,
    iso_week_end_date as expected

from data
