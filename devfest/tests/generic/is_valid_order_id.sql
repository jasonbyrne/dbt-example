{% test is_valid_order_id(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} !~ '^[A-Z]{2}-20[0-9]{2}-[0-9]{6}$';

{% endtest %}
