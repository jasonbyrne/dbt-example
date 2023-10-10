{% test is_valid_product_id(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} !~ '^[A-Z]{2}-[A-Z]{2}-[0-9]{8}$';

{% endtest %}