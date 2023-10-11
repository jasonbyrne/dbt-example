-- Get orders
WITH orders AS (
    SELECT DISTINCT
        order_id
        , order_date
        , ship_date
        , ship_mode_id
        , address_id
    FROM {{ ref('stg__orders') }}
)

-- Get returned orders
, returned_orders AS (
    SELECT order_id FROM {{ ref('stg__returns') }}
)

-- Get sum of order sales by item
, order_sales AS (
    SELECT 
        order_id
        , SUM(sales_cents) AS total_cents
        , SUM(profit_cents) AS profit_cents
    FROM {{ ref('order_item') }}
    GROUP BY order_id
)

-- Get sales person from address
, sales_person AS (
    SELECT 
        address.address_id
        , region.salesperson_name
        , region.commission_percentage
    FROM {{ ref('address') }} AS address
    JOIN {{ ref('stg__sales_regions') }} AS region
        ON address.region_id = region.region_id
)


, final AS (
    SELECT 
        orders.*
        , CASE WHEN returned_orders.order_id IS NULL THEN false ELSE true END AS is_returned
        , order_sales.total_cents
        , order_sales.profit_cents
        , sales_person.salesperson_name
        , CASE WHEN returned_orders.order_id IS NOT NULL THEN 0
            ELSE ROUND(order_sales.total_cents * (sales_person.commission_percentage / 100)) 
            END AS commission_cents
    FROM orders
    LEFT OUTER JOIN returned_orders
        ON orders.order_id = returned_orders.order_id
    LEFT OUTER JOIN order_sales
        ON orders.order_id = order_sales.order_id
    LEFT OUTER JOIN sales_person
        ON orders.address_id = sales_person.address_id

)

SELECT * FROM final