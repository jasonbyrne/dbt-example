
WITH na_sales AS (
    SELECT
        game_id
        , console_id
        , 'na' as region_id
        , na_sales AS sales_subtotal
    FROM {{ ref('stg__sales') }}
    WHERE na_sales > 0
),
eu_sales AS (
    SELECT
        game_id
        , console_id
        , 'eu' as region_id
        , eu_sales AS sales_subtotal
    FROM {{ ref('stg__sales') }}
    WHERE eu_sales > 0
),
jp_sales AS (
    SELECT
        game_id
        , console_id
        , 'jp' as region_id
        , jp_sales AS sales_subtotal
    FROM {{ ref('stg__sales') }}
    WHERE jp_sales > 0
),
other_sales AS (
    SELECT
        game_id
        , console_id
        , 'other' as region_id
        , other_sales AS sales_subtotal
    FROM {{ ref('stg__sales') }}
    WHERE other_sales > 0
),

-- Combine all sales data into one table

merged AS (
    SELECT * FROM na_sales
    UNION ALL
    SELECT * FROM eu_sales
    UNION ALL
    SELECT * FROM jp_sales
    UNION ALL
    SELECT * FROM other_sales
)

, final AS (
    SELECT 
        {{ dbt_utils.generate_surrogate_key(['game_id', 'console_id', 'region_id']) }} AS id,
        *
    FROM merged
)

SELECT * FROM final