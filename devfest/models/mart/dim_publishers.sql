

WITH source AS (
    SELECT 
        publisher_id
        , publisher_name
        , release_year
        , global_sales
        , all_time_rank
    FROM {{ ref('stg__sales') }}
)

, final AS (
    SELECT 
        publisher_id
        , publisher_name
        , SUM(global_sales) AS total_sales
        , MIN(release_year) AS first_year
        , MAX(release_year) AS last_year
        , COUNT(1) AS ranked_games_count
        , MIN(all_time_rank) AS best_rank
    FROM source
    GROUP BY publisher_id, publisher_name
)

SELECT * FROM final