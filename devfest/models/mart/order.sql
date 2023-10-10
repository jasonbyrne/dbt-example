WITH orders AS (
    SELECT DISTINCT
        order_id
        , order_date
        , ship_date
        , ship_mode_id
        , address_id
    FROM {{ ref('stg__orders') }}
)

, returned_orders AS (
    SELECT order_id FROM {{ ref('stg__returns') }}
)

, final AS (
    SELECT 
        orders.*
        , CASE WHEN returned_orders.order_id IS NULL THEN false ELSE true END AS is_returned
    FROM orders
    LEFT OUTER JOIN returned_orders
        ON orders.order_id = returned_orders.order_id
)

SELECT * FROM final