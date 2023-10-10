WITH source AS (
    SELECT DISTINCT
        address_id
        , customer_id
        , city_name
        , state_code
        , country_code
        , postal_code
        , region_name
    FROM {{ ref('stg__orders') }}
)

SELECT * FROM source