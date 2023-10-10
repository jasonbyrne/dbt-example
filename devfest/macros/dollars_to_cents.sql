{% macro dollars_to_cents(column_name) %}
    ROUND({{ column_name }} * 100)::INT
{% endmacro %}