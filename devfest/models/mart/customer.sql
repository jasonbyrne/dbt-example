WITH source AS (
    SELECT DISTINCT
        customer_id
        , customer_name
        , segment_id
    FROM {{ ref('stg__orders') }}
)

SELECT * FROM source