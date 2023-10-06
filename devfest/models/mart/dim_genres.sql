WITH final AS (
    SELECT 
        genre_id
        , genre_name 
        , MIN(release_year) AS first_year
        , MAX(release_year) AS last_year
        , MIN(all_time_rank) AS best_rank
        , COUNT(1) AS games_count
        , SUM(global_sales) AS total_sales
    FROM {{ ref('stg__sales') }}
    GROUP BY genre_id, genre_name
)

SELECT * FROM final