{% macro generate_id(column_name) %}
    MD5(LOWER({{ column_name }}))
{% endmacro %}