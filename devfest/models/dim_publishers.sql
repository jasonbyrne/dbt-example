

WITH source AS (
    SELECT 
        {{ generate_id('publisher') }} AS publisher_id
        , publisher AS publisher_name
        , year
        , global_sales
        , rank
    FROM {{ ref('raw__sales') }}
)

, final AS (
    SELECT 
        publisher_id
        , publisher_name
        , SUM(global_sales) AS total_sales
        , MIN(year) AS first_year
        , MAX(year) AS last_year
        , COUNT(*) AS ranked_games_count
        , MIN(rank) AS best_rank
    FROM source
    GROUP BY publisher_id, publisher_name
)

SELECT * FROM final