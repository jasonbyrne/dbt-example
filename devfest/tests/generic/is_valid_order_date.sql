{% test is_valid_order_date(model, column_name) %}

    select *
    from {{ model }}
    where {{ column_name }} NOT BETWEEN '2010-01-01' AND CURRENT_DATE

{% endtest %}