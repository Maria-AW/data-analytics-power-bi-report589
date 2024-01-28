SELECT 
  category,
  country,
  full_region,
  SUM((sale_price - cost_price) * product_quantity) AS "profit"
FROM 
  forquerying2
WHERE 
  full_region = 'Wiltshire, UK' AND EXTRACT(YEAR FROM CAST(dates AS DATE)) = 2021
GROUP BY
  category, country, full_region
ORDER BY 
  "profit" DESC
LIMIT 1;