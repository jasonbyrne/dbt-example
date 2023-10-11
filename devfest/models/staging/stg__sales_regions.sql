WITH source AS (
    SELECT
        region_name
        , salesperson
        , commission
        , email
    FROM {{ ref('seed__sales_regions') }}
)

, final as (
    SELECT
        {{ generate_id('region_name') }} AS region_id
        , region_name
        , salesperson AS salesperson_name
        , email AS salesperson_email
        , commission AS commission_rate
        , commission * 100 AS commission_percentage
    FROM source
)

SELECT * FROM final