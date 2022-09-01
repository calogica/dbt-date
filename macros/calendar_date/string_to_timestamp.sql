-- dates are stored like 'Apr 1, 2022'
-- times are like '1:23:45 AM' (no timezone) or '01:23:45 AM' (no timezone)

-- this macro refers to the string_to_date macro in order to return a full timestamp. Should it return just a TIME instead? 
-- I presume ultimately everyone will concat these together to have a timestamp, but maybe we could split them up.
{%- macro string_to_timestamp(date_string, time_string='12:00:00 AM', date_format='MMM D%, YYYY', time_format='h12:mm:ss am') -%}
    {{ adapter.dispatch('string_to_timestamp', 'dbt_date') (date_string, time_string, date_format, time_format) }}
{%- endmacro -%}

{%- macro default__string_to_timestamp(date_string, time_string, date_format, time_format) -%}
cast( {{ dbt_date.string_to_date(date_string, date_format) }} || ' ' || lpad('{{ time_string }}', 11, '0') as {{ dbt_utils.type_timestamp() }}) -- remove dbt_utils reference
{%- endmacro -%}

{%- macro bigquery__string_to_timestamp(date_string, time_string, date_format, time_format) -%}
parse_timestamp("%F %l:%M:%S %p", {{ dbt_date.string_to_date(date_string, date_format) }} || ' ' || lpad('{{ time_string }}', 11, '0'))
{%- endmacro -%}

{%- macro snowflake__string_to_timestamp(date_string, time_string, date_format, time_format) -%}
to_timestamp_ntz({{ dbt_date.string_to_date(date_string, date_format) }} || ' ' || lpad('{{ time_string }}', 11, '0'), 'yyyy-mm-dd hh12:mi:ss am') 
{%- endmacro -%}

{%- macro spark__string_to_timestamp(date_string, time_string, date_format, time_format) -%}
to_timestamp({{ dbt_date.string_to_date(date_string, date_format) }} || ' ' || lpad( '{{ time_string }}', 11, '0'), 'yyyy-MM-dd h:m:s a') 
{%- endmacro -%}