WITH final AS (
    SELECT
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('platform') }} AS console_id
        , year AS year_released
    FROM {{ ref('raw__sales') }}
)

SELECT * FROM final