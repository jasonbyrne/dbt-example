-- Rename columns so that they're easier to work with and conform to our conventions
WITH renamed AS (
    SELECT
        "Order ID" AS order_id
        , "Order Date" AS order_date
        , "Ship Date"  AS ship_date
        , "Ship Mode" AS ship_mode_name
        , "Customer ID" AS customer_id
        , "Customer Name" AS customer_name
        , "Segment" AS segment_name
        , "Country" AS country_name
        , "City" AS city_name
        , "State" AS state_name
        , "Postal Code" AS postal_code
        , "Region" AS region_name
        , "Product ID" AS product_id
        , "Product Name" AS product_name
        , "Category" AS category_name
        , "Sub-Category" AS sub_category_name
        , "Sales" AS sales_dollars
        , "Profit" AS profit_dollars
        , "Quantity"::INT AS quantity
        , "Discount"::NUMERIC AS discount_ratio
    FROM {{ source('sales', 'raw__orders') }}
)

-- Clean up the data types and values
, cleaned AS (
    SELECT
        order_id
        , TO_DATE(order_date, 'MM/DD/YY') AS order_date
        , TO_DATE(order_date, 'MM/DD/YY')  AS ship_date
        , ship_mode_name
        , customer_id
        , customer_name
        , segment_name
        , country_name
        , city_name
        , state_name
        , LPAD(postal_code::TEXT, 5, '0') AS postal_code
        , region_name
        , product_id
        , product_name
        , category_name
        , sub_category_name
        , {{ dollars_to_cents('sales_dollars') }} AS sales_cents
        , {{ dollars_to_cents('profit_dollars') }} AS profit_cents
        , quantity::INT
        , discount_ratio::NUMERIC
    FROM renamed
)

-- Generate surrogate keys for the dimensions and add enrichment columns
,  final AS (
    SELECT
        order_id
        , order_date
        , ship_date
        , {{ generate_id('ship_mode_name') }} AS ship_mode_id
        , ship_mode_name
        , customer_id
        , {{ dbt_utils.generate_surrogate_key(['customer_id', 'postal_code']) }} AS address_id
        , customer_name
        , {{ generate_id('segment_name') }} AS segment_id
        , segment_name
        , country_name
        , countries.alpha_3 AS country_code
        , city_name
        , states.abbreviation AS state_code
        , state_name
        , postal_code
        , region_name
        , product_id
        , product_name
        , category_name
        , sub_category_name
        , sales_cents
        , quantity
        , discount_ratio * 100 AS discount_percentage
        , profit_cents
        , ROUND(sales_cents / quantity)::INT AS unit_price_cents
        , ROUND(sales_cents / (1 - discount_ratio))::INT AS original_price_cents
    FROM cleaned
    INNER JOIN {{ ref('seed__states') }} AS states 
        ON cleaned.state_name = states.name
    INNER JOIN {{ ref('seed__countries') }} AS countries 
        ON cleaned.country_name = countries.name
)

SELECT * FROM final