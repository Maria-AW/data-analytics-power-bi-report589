SELECT SUM(staff_numbers) as "Total staff in the UK"
FROM dim_store
WHERE country = 'UK'