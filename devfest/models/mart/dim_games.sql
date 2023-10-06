{{ config(
    materialized = 'table',
    indexes=[
      {'columns': ['game_id'], 'unique': true }
    ]
)}}

WITH games AS (
    SELECT 
        game_id
        , game_name
    FROM {{ ref('stg__sales') }}
    GROUP BY game_id, game_name
)

, sales AS (
    SELECT 
        game_id
        , release_year
        , all_time_rank
        , global_sales
    FROM {{ ref('stg__sales') }}
)

, sales_agg AS (
    SELECT 
        game_id
        , SUM(global_sales) AS total_sales
        , MIN(release_year) AS first_year
        , MAX(release_year) AS last_year
        , COUNT(1) AS console_count
        , MIN(all_time_rank) AS best_rank
    FROM sales
    GROUP BY game_id
)

, final AS (
    SELECT 
        sales_agg.game_id
        , games.game_name
        , sales_agg.total_sales
        , sales_agg.first_year
        , sales_agg.last_year
        , sales_agg.console_count
        , sales_agg.best_rank
    FROM sales_agg
    INNER JOIN games
        ON sales_agg.game_id = games.game_id
)

SELECT * FROM final