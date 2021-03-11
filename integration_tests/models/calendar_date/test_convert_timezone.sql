{# We get the timezones conversions to test for each platform #}
{%- if target.name == "bq" %}
{% set rel = ref("data_convert_timezone_bq") %}
{%- else %}
{% set rel = ref("data_convert_timezone") %}
{%- endif -%}

{% set timezones_query %}
select distinct source_tz, target_tz
from {{ rel }}
{% endset %}

{% set tz_conversions = run_query(timezones_query) %}

with data as (
    select * from {{ rel }}
)
{%- for tz_conversion in tz_conversions %}
select
    source_ts,
    source_tz || ' to ' || target_tz as test_case,
    {{ dbt_date.convert_timezone('source_ts', source_tz=tz_conversion[0], target_tz=tz_conversion[1]) }} as actual,
    target_ts as expected

from data
where source_tz = '{{ tz_conversion[0] }}' and target_tz = '{{ tz_conversion[1] }}'
{% if not loop.last %}union all{% endif %}

{% endfor %}
