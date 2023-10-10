WITH source AS (
    SELECT DISTINCT
       segment_id
       , segment_name
    FROM {{ ref('stg__orders') }}
)

SELECT * FROM source