

WITH sales AS (
    SELECT 
        console_id
        , release_year
        , all_time_rank
        , global_sales
    FROM {{ ref('stg__sales') }}
)

, sales_agg AS (
    SELECT 
        console_id
        , MIN(release_year) AS first_year
        , MAX(release_year) AS last_year
        , COUNT(1) AS ranked_games_count
        , MIN(all_time_rank) AS best_rank
        , SUM(global_sales) AS total_sales
    FROM sales
    GROUP BY console_id
)

, final AS (
    SELECT
        consoles.console_id
        , consoles.console_name
        , consoles.manufacturer_id
        , sales_agg.first_year
        , sales_agg.last_year
        , sales_agg.ranked_games_count
        , sales_agg.best_rank
        , sales_agg.total_sales
    FROM  {{ ref('stg__consoles') }} AS consoles
    INNER JOIN sales_agg
        ON consoles.console_id = sales_agg.console_id
)

SELECT * FROM final