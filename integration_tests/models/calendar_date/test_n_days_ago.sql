
with data as (

    select * from {{ ref('data_n_days_ago') }}

)

select
    {{ dbt_date.n_days_ago(7, 'date_day') }} as actual,
    seven_days_ago as expected

from data

union all

select
    {{ dbt_date.n_days_ago(1, 'date_day') }} as actual,
    one_day_ago as expected

from data

union all

select
    {{ dbt_date.n_days_ago(-2, 'date_day') }} as actual,
    minus_two_days_ago as expected

from data
