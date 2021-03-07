
with data as (

    select * from {{ ref('data_n_days_away') }}

)

select
    {{ dbt_date.n_days_away(7, 'date_day') }} as actual,
    seven_days_away as expected

from data

union all

select
    {{ dbt_date.n_days_away(1, 'date_day') }} as actual,
    one_day_away as expected

from data

union all

select
    {{ dbt_date.n_days_away(-2, 'date_day') }} as actual,
    minus_two_days_away as expected

from data
