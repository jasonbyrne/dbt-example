

WITH final AS (
    SELECT 
        {{ generate_id('manufacturer') }} AS manufacturer_id
        , manufacturer AS manufacturer_name
    FROM {{ ref('raw__consoles') }}
)



SELECT * FROM final