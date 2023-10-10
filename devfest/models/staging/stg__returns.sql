WITH cleaned AS (
    SELECT
        "Order ID" as order_id
    FROM {{ source('sales', 'raw__returns') }}
    WHERE "Returned" = 'Yes'
)

SELECT * FROM cleaned