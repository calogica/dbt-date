
with data as (

    select * from {{ ref('data_iso_week_start') }}

)

select
    {{ dbt_date.iso_week_start('date_day') }} as actual,
    iso_week_start_date as expected

from data
