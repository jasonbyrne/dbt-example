

WITH final AS (
    SELECT 
        manufacturer_id
        , manufacturer_name
    FROM {{ ref('stg__consoles') }}
    GROUP BY manufacturer_id, manufacturer_name
)



SELECT * FROM final