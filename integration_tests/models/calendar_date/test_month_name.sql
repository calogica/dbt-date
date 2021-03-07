
with data as (

    select * from {{ ref('data_month_name') }}

)

select
    {{ dbt_date.month_name('date_day', short=true) }} as actual,
    short as expected

from data

union all

select
    {{ dbt_date.month_name('date_day', short=false) }} as actual,
    long as expected

from data
