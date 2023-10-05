WITH final AS (
    SELECT 
        {{ generate_id('genre') }} AS genre_id
        , genre AS genre_name 
        , year
        , rank
        , global_sales
    FROM {{ ref('raw__sales') }}
)

SELECT * FROM final