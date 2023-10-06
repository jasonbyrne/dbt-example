WITH cleaned AS (
    SELECT 
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('genre') }} AS genre_id
        , {{ generate_id('publisher') }} AS publisher_id
        , {{ generate_id('platform') }} AS console_id
        , name AS game_name
        , platform AS console_name
        , genre AS genre_name
        , publisher AS publisher_name
        , rank AS all_time_rank
        , year AS release_year
        , ROUND(na_sales * 1000000) AS na_sales
        , ROUND(eu_sales * 1000000) AS eu_sales
        , ROUND(jp_sales * 1000000) AS jp_sales
        , ROUND(other_sales * 1000000) AS other_sales
        , ROUND(global_sales * 1000000) AS global_sales
    FROM {{ ref('raw__sales') }}
)

SELECT * FROM cleaned