
with data as (

    select * from {{ ref('data_convert_timezone') }}

)

select
    {# UTC to America/Los_Angeles #}
    {{ dbt_date.convert_timezone('date_day') }} as actual,
    var_tz as expected

from data

union all

select
    {# UTC to America/New_York #}
    {{ dbt_date.convert_timezone('date_day', 'America/New_York') }} as actual,
    target_tz as expected

from data

union all

select
    {# America/Los_Angeles to America/New_York #}
    {{ dbt_date.convert_timezone('date_day', 'America/New_York', 'America/Los_Angeles') }} as actual,
    source_tz as expected

from data

union all

select
    {# America/New_York to America/Los_Angeles #}
    {{ dbt_date.convert_timezone('date_day', source_tz='America/New_York') }} as actual,
    var_source_tz as expected

from data
