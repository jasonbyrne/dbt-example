

WITH sales AS (
    SELECT 
        {{ generate_id('platform') }} AS console_id
        , year
        , rank
        , global_sales
    FROM {{ ref('raw__sales') }}
),

 consoles AS (
    SELECT 
        {{ generate_id('id') }} AS console_id
        , name AS console_name
        , {{ generate_id('manufacturer') }} AS manufacturer_id
    FROM {{ ref('raw__consoles') }}
)

, sales_agg AS (
    SELECT 
        console_id
        , MIN(year) AS first_year
        , MAX(year) AS last_year
        , COUNT(*) AS ranked_games_count
        , MIN(rank) AS best_rank
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
    FROM consoles
    INNER JOIN sales_agg
        ON consoles.console_id = sales_agg.console_id
)

SELECT * FROM final