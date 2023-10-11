WITH source AS (
    SELECT * FROM {{ ref('stg__sales_regions') }}
)

SELECT * FROM source