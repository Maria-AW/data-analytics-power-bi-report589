SELECT 
  country,
  store_type,
  SUM(sale_price * product_quantity) AS "Revenue"
FROM 
  forquerying2
WHERE 
  country = 'Germany' AND EXTRACT(YEAR FROM CAST(dates AS DATE)) = 2022
GROUP BY
  store_type, country
ORDER BY 
  "Revenue" DESC
LIMIT 1;