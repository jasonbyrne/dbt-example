
WITH na_sales AS (
    SELECT
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('platform') }} AS console_id
        , 'na' as region_id
        , na_sales AS sales_subtotal
    FROM {{ ref('raw__sales') }}
    WHERE na_sales > 0
),
eu_sales AS (
    SELECT
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('platform') }} AS console_id
        , 'eu' as region_id
        , eu_sales AS sales_subtotal
    FROM {{ ref('raw__sales') }}
    WHERE eu_sales > 0
),
jp_sales AS (
    SELECT
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('platform') }} AS console_id
        , 'jp' as region_id
        , jp_sales AS sales_subtotal
    FROM {{ ref('raw__sales') }}
    WHERE jp_sales > 0
),
other_sales AS (
    SELECT
        {{ generate_id('name') }} AS game_id
        , {{ generate_id('platform') }} AS console_id
        , 'other' as region_id
        , other_sales AS sales_subtotal
    FROM {{ ref('raw__sales') }}
    WHERE other_sales > 0
),

-- Combine all sales data into one table

final AS (
    SELECT * FROM na_sales
    UNION ALL
    SELECT * FROM eu_sales
    UNION ALL
    SELECT * FROM jp_sales
    UNION ALL
    SELECT * FROM other_sales
)

SELECT * FROM final