{%- macro string_to_date(date_string, format='Mon DD, YYYY') -%}
    {{ adapter.dispatch('string_to_date', 'dbt_date') (date_string, format) }}
{%- endmacro -%}

{%- macro default__string_to_date(date_string, format) -%}
-- redshift and postgres are actually pretty good at detecting date strings. we'll add compatibility for Day/Month/Year format

{% if format|lower in ('d/m/yy', 'dd/mm/yy') %}
-- Ex: (0)1/(4)/22
to_date('{{ date_string }}', 'dd/mm/yy')

{% elif format|lower in ('d/m/yyyy', 'dd/mm/yyyy') %}
-- Ex: (0)1/(4)/2022
to_date('{{ date_string }}', 'dd/mm/yyyy')

{% else %}
cast('{{ date_string }}' as date)

{% endif %}

{%- endmacro -%}

{%- macro bigquery__string_to_date(date_string, format) -%}

{% if format|lower[:3] = 'mon' %}
-- Ex: Apr(il) (0)1, 2022
parse_date("%b %e, %Y", '{{ date_string }}')

{% elif format|lower[:5] = 'd mon' or format|lower[:6] = 'dd mon' %}
-- Ex: (0)1 Apr(il) 2022
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

{% elif format|lower in ('dd-mon-yyyy', 'd-mon-yyyy') %}
-- Ex: APR-(0)1-2022
parse_date("%b-%e-%Y", '{{ date_string }}')

{% else %}
parse_date("%F", '{{ date_string }}')

{% endif %}

{%- endmacro -%}

{%- macro snowflake__string_to_date(date_string, format) -%}

{% if format|lower[:3] = 'mon' %}
-- Ex: Apr(il) (0)1, 2022
date('{{ date_string }}', 'mon dd, yyyy')

{% elif format|lower[:5] = 'd mon' or format|lower[:6] = 'dd mon' %}
-- Ex: (0)1 Apr(il) 2022
date('{{ date_string }}', 'dd mon yyyy')

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
date('{{ date_string }}', 'dd/mm/yyyy')

{% elif format|lower in ('dd-mon-yyyy', 'd-mon-yyyy') %}
-- Ex: (0)1-APR-2022
date('{{ date_string }}', 'dd-mon-yyyy')

{% elif format|lower in ('dd-mon-yyyy', 'd-mon-yyyy') %}
-- Ex: APR-(0)1-2022
date('{{ date_string }}', 'mon-dd-yyyy')

{% else %}
date('{{ date_string }}', 'auto')

{% endif %}

{%- endmacro -%}

{%- macro spark__string_to_date(date_string, format) -%}

{% if format|lower[:5] = 'month' %}
-- Ex: April (0)1, 2022
to_date('{{ date_string }}', 'MMMM d, y')

{% eliif format|lower[:3] = 'mon' %}
-- Ex: Apr (0)1, 2022
to_date('{{ date_string }}', 'MMM d, y')

{% elif format|lower[:7] = 'd month' or format|lower[:8] = 'dd month' %}
-- Ex: (0)1 April 2022
to_date('{{ date_string }}', 'd MMMM y')

{% elif format|lower[:5] = 'd mon' or format|lower[:6] = 'dd mon' %}
-- Ex: (0)1 Apr 2022
to_date('{{ date_string }}', 'd MMM y')

{% elif format|lower in ('m/d/yy', 'mm/dd/yy') %}
-- Ex: (0)4/(0)1/22
to_date('{{ date_string }}', 'M/d/yy')

{% elif format|lower in ('m/d/yyyy', 'mm/dd/yyyy') %}
-- Ex: (0)4/(0)1/2022
to_date('{{ date_string }}','M/d/y')

{% elif format|lower in ('d/m/yy', 'dd/mm/yy') %}
-- Ex: (0)1/(4)/22
to_date('{{ date_string }}', 'd/M/yy')

{% elif format|lower in ('d/m/yyyy', 'dd/mm/yyyy') %}
-- Ex: (0)1/(4)/2022
to_date('{{ date_string }}', 'd/MM/y')

{% elif format|lower in ('dd-mon-yyyy', 'd-mon-yyyy') %}
-- Ex: (0)1-APR-2022
to_date('{{ date_string }}', 'd-MMM-y')

{% elif format|lower in ('mon-dd-yyyy', 'mon-d-yyyy') %}
-- Ex: APR-(0)1-2022
to_date('{{ date_string }}', 'MMM-d-y')

{% else %}
to_date('{{ date_string }}')

{% endif %}

{%- endmacro -%}
