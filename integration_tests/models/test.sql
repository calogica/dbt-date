select 

{{ dbt_date.string_to_date('Nov 29, 2020', 'Mon d, yyyy') }} as A
{# ,
{{ dbt_date.string_to_date('date_string_B', 'format_date_B') }} as B,
{{ dbt_date.string_to_date('date_string_C', 'format_date_C') }} as C,
{{ dbt_date.string_to_date('date_string_D', 'format_date_D') }} as D,
{{ dbt_date.string_to_date('date_string_E', 'format_date_E') }} as E,
{{ dbt_date.string_to_date('date_string_F', 'format_date_F') }} as F,
{{ dbt_date.string_to_date('date_string_G', 'format_date_G') }} as G,
{{ dbt_date.string_to_date('date_string_H', 'format_date_H') }} as H,
{{ dbt_date.string_to_date('date_string_I', 'format_date_I') }} as I,
{{ dbt_date.string_to_date('date_string_J', 'format_date_J') }} as J,
{{ dbt_date.string_to_date('date_string_K', 'format_date_K') }} as K,
{{ dbt_date.string_to_date('date_string_L', 'format_date_L') }} as L,
{{ dbt_date.string_to_date('date_string_M', 'format_date_M') }} as M,
{{ dbt_date.string_to_date('date_string_N', 'format_date_N') }} as N,
{{ dbt_date.string_to_date('date_string_O', 'format_date_O') }} as O,
{{ dbt_date.string_to_date('date_string_P', 'format_date_P') }} as P,
{{ dbt_date.string_to_date('date_string_Q', 'format_date_Q') }} as Q,
{{ dbt_date.string_to_date('date_string_R', 'format_date_R') }} as R #}

from {{ ref('test_dates') }}