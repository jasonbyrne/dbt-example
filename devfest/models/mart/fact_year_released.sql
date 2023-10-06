WITH final AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['game_id', 'console_id']) }} AS id
        , game_id
        , console_id
        , genre_id
        , release_year
    FROM {{ ref('stg__sales') }}
)

SELECT * FROM final