{% macro get_platform_relation(relation_name) -%}
{{ adapter.dispatch('get_platform_relation') (relation_name) }}
{%- endmacro %}

{% macro default__get_platform_relation(relation_name) -%}
{{ ref(relation_name) }}
{%- endmacro %}

{% macro bigquery__get_platform_relation(relation_name) -%}
{%- set relation_name = relation_name ~ "_bq" -%}
{{ ref(relation_name) }}
{%- endmacro %}
