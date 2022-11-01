{# 
    currently supports dates stored like 'Apr 1, 2022' -> 'Mon D, YYYY'
    other formats to be covered: 
    - 'Apr 01, 2022' -> 'Mon DD, YYYY'
    - 'April 1, 2022' -> 'Month D, YYYY'
    - 'April 01, 2022' -> 'Month DD, YYYY'
    - '1 April 2022' -> 'D Month YYYY'
    - '1 Apr 2022' -> 'D Mon YYYY'
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
    ' DD-MON-YYYY'
#}
-- months are same Mon vs Month for
-- BQ
-- snowlfkae


{%- macro string_to_date(date_string, format='Mon DD, YYYY') -%}
    {{ adapter.dispatch('string_to_date', 'dbt_date') (date_string, format) }}
{%- endmacro -%}

{%- macro default__string_to_date(date_string, format) -%}

{% if format = %}

cast('{{ date_string }}' as date)
{%- endmacro -%}

{%- macro bigquery__string_to_date(date_string, format) -%}

{% if format|lower[:3] = 'mon' %}
-- Ex: Apr(il) (0)1, 2022
parse_date("%b %e, %Y", '{{ date_string }}')

{% elif format|lower[:5] = 'd mon' or format|lower[:6] = 'dd mon' %}
-- Ex: (0)1 Apr(il), 2022
parse_date("%e %b %Y", '{{ date_string }}')

{% elif format|lower in ('m/d/yy', 'mm/dd/yy') %}
-- Ex: (0)4/(0)1/22
parse_date("%D", '{{ date_string }}')

{% elif format|lower in ('m/d/yyyy', 'mm/dd/yyyy') %}
-- Ex: (0)4/(0)1/2022
parse_date("%m/%e/%Y", '{{ date_string }}')

{% elif format|lower in ('d/m/yy', 'dd/mm/yy') %}
-- Ex: (0)1/(4)/22
parse_date("%e/%m/%y", '{{ date_string }}')

{% elif format|lower in ('d/m/yyyy', 'dd/mm/yyyy') %}
-- Ex: (0)1/(4)/2022
parse_date("%e/%m/%Y", '{{ date_string }}')

{% elif format|lower in ('dd-mon-yyyy', 'd-mon-yyyy') %}
-- Ex: (0)1-APR-2022
parse_date("%e-%b-%Y", '{{ date_string }}')

{% else %}
parse_date("%F", '{{ date_string }}')
{% endf %}

{%- endmacro -%}

{%- macro snowflake__string_to_date(date_string, format) -%}

{% if format|lower[:3] = 'mon' %}
-- Ex: Apr(il) (0)1, 2022
date('{{ date_string }}', 'mon dd, yyyy')

{% elif format|lower[:5] = 'd mon' or format|lower[:6] = 'dd mon' %}
-- Ex: (0)1 Apr(il), 2022
date('{{ date_string }}', 'dd mon, yyyy')

{% elif format|lower in ('m/d/yy', 'mm/dd/yy') %}
-- Ex: (0)4/(0)1/22
date('{{ date_string }}', 'mm/dd/yy')

{% elif format|lower in ('m/d/yyyy', 'mm/dd/yyyy') %}
-- Ex: (0)4/(0)1/2022
date('{{ date_string }}', 'mm/dd/yyyy')

{% elif format|lower in ('d/m/yy', 'dd/mm/yy') %}
-- Ex: (0)1/(4)/22
date('{{ date_string }}', 'dd/mm/yy')

{% elif format|lower in ('d/m/yyyy', 'dd/mm/yyyy') %}
-- Ex: (0)1/(4)/2022
date('{{ date_string }}', 'mm/dd/yyyy')

{% elif format|lower in ('dd-mon-yyyy', 'd-mon-yyyy') %}
-- Ex: (0)1-APR-2022
date('{{ date_string }}', 'dd-mon-yyyy')

{% else %}
date('{{ date_string }}', 'auto')
{% endf %}

{%- endmacro -%}

{%- macro spark__string_to_date(date_string, format) -%}
to_date('{{ date_string }}', 'MMM d, y')
{# 
    MMMM for full month name
    dd for 0-padded single digit days? d may also work....
    yy for just 2-digit year representation
#}
{%- endmacro -%}
