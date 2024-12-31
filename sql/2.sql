SELECT h.id, h.fio, v."name", v.payment, f."date" 
FROM humans h 
JOIN facts f ON h.id = f.driver 
JOIN violations v ON f.violation_id = v.id 
WHERE h.id IN (
	SELECT h.id
	FROM humans h
	JOIN facts f ON h.id = f.driver 
	GROUP BY h.id, h.fio
	HAVING COUNT(f.driver) = (SELECT MAX(num_driver) FROM 
		(SELECT COUNT(*) AS num_driver
	 	FROM facts f 
	 	GROUP BY driver)
	)
)
ORDER BY v.payment DESC;