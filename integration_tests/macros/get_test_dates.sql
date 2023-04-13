{% macro get_test_dates() -%}
select
    cast('2020-11-29' as date) as date_day,
    cast('2020-11-28' as date) as prior_date_day,
    cast('2020-11-30' as date) as next_date_day,
    'Sunday' as day_name,
    'Sun' as day_name_short,
    29 as day_of_month,
    1 as day_of_week,
    7 as iso_day_of_week,
    334 as day_of_year,
    cast('2020-11-29' as date) as week_start_date,
    cast('2020-12-05' as date) as week_end_date,
    {{ get_test_week_of_year()[0] }} as week_of_year,
    -- in ISO terms, this is the end of the prior week
    cast('2020-11-23' as date) as iso_week_start_date,
    cast('2020-11-29' as date) as iso_week_end_date,
    48 as iso_week_of_year,
    'November' as month_name,
    'Nov' as month_name_short,
    1623076520 as unix_epoch,
    cast('{{ get_test_timestamps()[0] }}' as {{ type_timestamp() }}) as time_stamp,
    cast('{{ get_test_timestamps()[1] }}' as {{ type_timestamp() }}) as time_stamp_utc,
    
    'Nov 29, 2020' as date_string_A,
    'Mon d, yyyy' as format_date_A,
    'Nov 29, 2020' as date_string_B,
    'mon dd, yyyy' as format_date_B,
    'November 29, 2020' as date_string_C,
    'Month d, yyyy' as format_date_C,
    'November 29, 2020' as date_string_D,
    'Month dd, yyyy' as format_date_D,
    '29 Nov 2020' as date_string_E,
    'd mon yyyy' as format_date_E,
    '29 Nov 2020' as date_string_F,
    'dd mon yyyy' as format_date_F,
    '29 November 2020' as date_string_G,
    'd month yyyy' as format_date_G,
    '29 November 2020' as date_string_H,
    'dd month yyyy' as format_date_H,
    '11/29/20' as date_string_I,
    'm/d/yy' as format_date_I,
    '11/29/20' as date_string_J,
    'mm/dd/yy' as format_date_J,
    '11/29/2020' as date_string_K,
    'm/d/yyyy' as format_date_K,
    '11/29/2020' as date_string_L,
    'mm/dd/yyyy' as format_date_L,
    '29-Nov-2020' as date_string_M,
    'dd-mon-yyyy' as format_date_M,
    'nov-29-2020' as date_string_N,
    'mon-dd-yyyy' as format_date_N,
    '29/11/20' as date_string_O,
    'd/m/yy' as format_date_O,
    '29/11/20' as date_string_P,
    'dd/mm/yy' as format_date_P,
    '29/11/2020' as date_string_Q,
    'd/m/yyyy' as format_date_Q,
    '29/11/2020' as date_string_R,
    'dd/mm/yyyy' as format_date_R

union all

select
    cast('2020-12-01' as date) as date_day,
    cast('2020-11-30' as date) as prior_date_day,
    cast('2020-12-02' as date) as next_date_day,
    'Tuesday' as day_name,
    'Tue' as day_name_short,
    1 as day_of_month,
    3 as day_of_week,
    2 as iso_day_of_week,
    336 as day_of_year,
    cast('2020-11-29' as date) as week_start_date,
    cast('2020-12-05' as date) as week_end_date,
    {{ get_test_week_of_year()[1] }}  as week_of_year,
    cast('2020-11-30' as date) as iso_week_start_date,
    cast('2020-12-06' as date) as iso_week_end_date,
    49 as iso_week_of_year,
    'December' as month_name,
    'Dec' as month_name_short,
    {# 1623051320 as unix_epoch, #}
    1623076520 as unix_epoch,
    cast('{{ get_test_timestamps()[0] }}' as {{ type_timestamp() }}) as time_stamp,
    cast('{{ get_test_timestamps()[1] }}' as {{ type_timestamp() }}) as time_stamp_utc,

    'Dec 1, 2020' as date_string_A,
    'Mon d, yyyy' as format_date_A,
    'Dec 01, 2020' as date_string_B,
    'mon dd, yyyy' as format_date_B,
    'December 1, 2020' as date_string_C,
    'Month d, yyyy' as format_date_C,
    'December 01, 2020' as date_string_D,
    'Month dd, yyyy' as format_date_D,
    '1 Dec 2020' as date_string_E,
    'd mon yyyy' as format_date_E,
    '01 Dec 2020' as date_string_F,
    'dd mon yyyy' as format_date_F,
    '1 December 2020' as date_string_G,
    'd month yyyy' as format_date_G,
    '01 December 2020' as date_string_H,
    'dd month yyyy' as format_date_H,
    '12/1/20' as date_string_I,
    'm/d/yy' as format_date_I,
    '12/01/20' as date_string_J,
    'mm/dd/yy' as format_date_J,
    '12/1/2020' as date_string_K,
    'm/d/yyyy' as format_date_K,
    '12/01/2020' as date_string_L,
    'mm/dd/yyyy' as format_date_L,
    '01-Dec-2020' as date_string_M,
    'dd-mon-yyyy' as format_date_M,
    'dec-01-2020' as date_string_N,
    'mon-dd-yyyy' as format_date_N,
    '1/12/20' as date_string_O,
    'd/m/yy' as format_date_O,
    '01/12/20' as date_string_P,
    'dd/mm/yy' as format_date_P,
    '1/12/2020' as date_string_Q,
    'd/m/yyyy' as format_date_Q,
    '01/12/2020' as date_string_R,
    'dd/mm/yyyy' as format_date_R

{%- endmacro %}

{% macro get_test_week_of_year() -%}
    {{ return(adapter.dispatch('get_test_week_of_year', 'dbt_date_integration_tests') ()) }}
{%- endmacro %}

{% macro default__get_test_week_of_year() -%}
    {# weeks_of_year for '2020-11-29' and '2020-12-01', respectively #}
    {{ return([48,48]) }}
{%- endmacro %}

{% macro snowflake__get_test_week_of_year() -%}
    {# weeks_of_year for '2020-11-29' and '2020-12-01', respectively #}
    {# Snowflake uses ISO year #}
    {{ return([48,49]) }}
{%- endmacro %}



{% macro get_test_timestamps() -%}
    {{ return(adapter.dispatch('get_test_timestamps', 'dbt_date_integration_tests') ()) }}
{%- endmacro %}

{% macro default__get_test_timestamps() -%}
    {{ return(['2021-06-07 07:35:20.000000 America/Los_Angeles',
                '2021-06-07 14:35:20.000000 UTC']) }}
{%- endmacro %}

{% macro bigquery__get_test_timestamps() -%}
    {{ return(['2021-06-07 07:35:20.000000',
                '2021-06-07 14:35:20.000000']) }}
{%- endmacro %}

{% macro snowflake__get_test_timestamps() -%}
    {{ return(['2021-06-07 07:35:20.000000 -0700',
                '2021-06-07 14:35:20.000000 -0000']) }}
{%- endmacro %}



