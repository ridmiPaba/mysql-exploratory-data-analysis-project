-- Explore All objects across the three warehouse layers
SELECT *
FROM information_schema.tables
WHERE table_schema IN ('bronze', 'silver', 'gold');

-- EAll columns across the three warehouse layers
SELECT *
FROM information_schema.columns
WHERE table_schema IN ('bronze', 'silver', 'gold')
AND table_name = 'dim_customer';