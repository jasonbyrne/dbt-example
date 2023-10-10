WITH source AS (
    SELECT DISTINCT
        product_id
        , product_name
        , category_name
        , sub_category_name
    FROM {{ ref('stg__orders') }}
)

SELECT * FROM source