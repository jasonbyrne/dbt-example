WITH source AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} AS order_item_id
        , order_id
        , product_id
        , quantity
        , sales_cents
        , profit_cents
        , discount_percentage
    FROM {{ ref('stg__orders') }}
)

SELECT * FROM source