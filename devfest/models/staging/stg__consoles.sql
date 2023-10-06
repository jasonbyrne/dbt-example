WITH cleaned AS (
    SELECT 
    {{ generate_id('id') }} AS console_id
    , name AS console_name
    , {{ generate_id('manufacturer')}} AS manufacturer_id
    , manufacturer AS manufacturer_name
    FROM {{ ref('raw__consoles') }}
)

SELECT * FROM cleaned
