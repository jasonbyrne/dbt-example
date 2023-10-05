WITH final AS (
    SELECT 
        {{ generate_id('genre') }} AS genre_id
        , genre AS genre_name 
        , MIN(year) AS first_year
        , MAX(year) AS last_year
        , MIN(rank) AS best_rank
        , COUNT(1) AS games_count
        , SUM(global_sales) AS total_sales
    FROM {{ ref('raw__sales') }}
    GROUP BY genre_id, genre_name
)

SELECT * FROM final