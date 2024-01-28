SELECT
    store_type AS "Store Type",
    SUM(sale_price) AS "Total Sales",
    (SUM(sale_price) / (SELECT SUM(sale_price) FROM forquerying2)) * 100 AS "Percentage of total sales",
    COUNT(*) AS "Total Orders"
FROM
    forquerying2
GROUP BY
    store_type;