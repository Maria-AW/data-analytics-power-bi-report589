SELECT 
  month_name,
  SUM(sale_price * product_quantity) AS "Revenue"
FROM 
  forquerying2
WHERE 
  EXTRACT(YEAR FROM CAST(dates AS DATE)) = 2022
GROUP BY
  month_name
ORDER BY 
  "Revenue" DESC
LIMIT 1;