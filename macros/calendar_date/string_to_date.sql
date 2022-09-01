{# 
    currently supports dates stored like 'Apr 1, 2022'
    other formats to be covered: 
    - 'Apr 01, 2022' -> 'MMM D, YYYY'
    - 'April 1, 2022' -> 'Month D, YYYY'
    - 'April 01, 2022' -> 'Month DD, YYYY'
    - '1 April 2022' -> 'D Month YYYY'
    - '1 Apr 2022' -> 'D MMM YYYY'
    - '4/1/22' -> 'M/D/YY'
    - '4/1/2022' -> 'M/D/YYYY'
    - '04/01/22' -> 'MM/DD/YY'
    - '04/01/2022' -> 'MM/DD/YYYY'

    If we want to support Day-Month-Year formats:
    - '1/4/22' -> 'D/M/YYY'
    - '1/4/2022' -> 'D/M/YYYY'
    - '01/04/22' -> 'DD/MM/YY'
    - '01/04/2022' -> 'DD/MM/YYYY'

    Anything else?
#}

{%- macro string_to_date(date_string, format='MMM D, YYYY') -%}
    {{ adapter.dispatch('string_to_date', 'dbt_date') (date_string, format) }}
{%- endmacro -%}

{%- macro default__string_to_date(date_string, format) -%}
cast('{{ date_string }}' as date)
{%- endmacro -%}

{%- macro bigquery__string_to_date(date_string, format) -%}
parse_date("%b %e, %Y", '{{ date_string }}')
{# 
    %B instead of %b for full month name
    %d instead of %e if single-digit days are padded with a '0' 
#}
{%- endmacro -%}

{%- macro snowflake__string_to_date(date_string, format) -%}
date('{{ date_string }}', 'mon dd, yyyy')
{# 
    no native format for full month name, will have to left(split_part(position: first, delimiter=':'), 3) for the abbreviation
    dd works for 1 or 2 digit-days
#}
{%- endmacro -%}

{%- macro spark__string_to_date(date_string, format) -%}
to_date('{{ date_string }}', 'MMM d, y')
{# 
    MMMM for full month name
    dd for 0-padded single digit days? d may also work....
    yy for just 2-digit year representation
#}
{%- endmacro -%}
