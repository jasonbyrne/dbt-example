WITH games AS (
    SELECT 
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('genre') }} AS genre_id
        , {{ generate_id('publisher') }} AS publisher_id
        , name AS game_name
    FROM {{ ref('raw__sales') }}
    GROUP BY game_id, genre_id, publisher_id, game_name
)

, sales AS (
    SELECT 
        {{ generate_id('name') }} AS game_id
        , year AS year_released
        , rank
        , global_sales
    FROM {{ ref('raw__sales') }}
)

, sales_agg AS (
    SELECT 
        game_id
        , SUM(global_sales) AS total_sales
        , MIN(year_released) AS first_year
        , MAX(year_released) AS last_year
        , COUNT(*) AS console_count
        , MIN(rank) AS best_rank
    FROM sales
    GROUP BY game_id
)

, final AS (
    SELECT 
        sales_agg.game_id
        , games.game_name
        , games.genre_id
        , games.publisher_id
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