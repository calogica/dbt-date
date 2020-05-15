{% macro get_date_dimension(start_date, end_date) %}
{{ adapter_macro('dbt_date.get_date_dimension', start_date, end_date) }}
{% endmacro %}

{% macro default__get_date_dimension(start_date, end_date) %}
with base_dates as (
    {{ dbt_date.get_base_dates(start_date, end_date) }}
),
dates_with_prior_year_dates as (
    select
        cast(d.day_date as date) as day_date,
        cast({{ dbt_utils.dateadd('year', -1 , 'd.day_date') }} as date) as prior_year_day_date,
        cast({{ dbt_utils.dateadd('day', -364 , 'd.day_date') }} as date) as prior_year_over_year_day_date
    from
    	base_dates d
)
select
    d.day_date,
    cast({{ dbt_utils.dateadd('day', -1 , 'd.day_date') }} as date) as prior_day_date,
    cast({{ dbt_utils.dateadd('day', 1 , 'd.day_date') }} as date) as next_day_date,
    d.prior_year_day_date as prior_year_day_date,
    d.prior_year_over_year_day_date,
    cast(
            case
                when {{ dbt_date.date_part('dayofweek', 'd.day_date') }} = 0 then 7
                else {{ dbt_date.date_part('dayofweek', 'd.day_date') }}
            end
        as {{ dbt_utils.type_int() }}
    ) as day_of_week,

    {{ dbt_date.day_name('d.day_date', short=false) }} as day_of_week_name,
    {{ dbt_date.day_name('d.day_date', short=true) }} as day_of_week_name_short,
    cast({{ dbt_date.date_part('day', 'd.day_date') }} as {{ dbt_utils.type_int() }}) as day_of_month,
    cast({{ dbt_date.date_part('dayofyear', 'd.day_date') }} as {{ dbt_utils.type_int() }}) as day_of_year,

    cast({{ dbt_utils.date_trunc('week', 'd.day_date') }} as date) as week_start_date,
    cast({{ dbt_utils.last_day('d.day_date', 'week') }} as date) as week_end_date,
    cast({{ dbt_date.date_part('week', 'd.day_date') }} as {{ dbt_utils.type_int() }}) as week_of_year,
    cast({{ dbt_utils.date_trunc('week', 'd.prior_year_over_year_day_date') }} as date) as prior_year_week_start_date,
    cast({{ dbt_utils.last_day('d.prior_year_over_year_day_date', 'week') }} as date) as prior_year_week_end_date,
    cast({{ dbt_date.date_part('week', 'd.prior_year_over_year_day_date') }} as {{ dbt_utils.type_int() }}) as prior_year_week_of_year,

    cast({{ dbt_date.date_part('month', 'd.day_date') }} as {{ dbt_utils.type_int() }}) as month_of_year,
    {{ dbt_date.month_name('d.day_date', short=false) }}  as month_name,
    {{ dbt_date.month_name('d.day_date', short=true) }}  as month_name_short,

    cast({{ dbt_utils.date_trunc('month', 'd.day_date') }} as date) as month_start_date,
    cast({{ dbt_utils.last_day('d.day_date', 'month') }} as date) as month_end_date,

    cast({{ dbt_utils.date_trunc('month', 'd.prior_year_day_date') }} as date) as prior_year_month_start_date,
    cast({{ dbt_utils.last_day('d.prior_year_day_date', 'month') }} as date) as prior_year_month_end_date,

    cast({{ dbt_date.date_part('quarter', 'd.day_date') }} as {{ dbt_utils.type_int() }}) as quarter_of_year,
    cast({{ dbt_utils.date_trunc('quarter', 'd.day_date') }} as date) as quarter_start_date,
    cast({{ dbt_utils.last_day('d.day_date', 'quarter') }} as date) as quarter_end_date,

    cast({{ dbt_date.date_part('year', 'd.day_date') }} as {{ dbt_utils.type_int() }}) as year_number,
    cast({{ dbt_utils.date_trunc('year', 'd.day_date') }} as date) as year_start_date,
    cast({{ dbt_utils.last_day('d.day_date', 'year') }} as date) as year_end_date
from
    dates_with_prior_year_dates d
order by 1
{% endmacro %}
