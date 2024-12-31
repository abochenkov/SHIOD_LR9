SELECT h.id, h.fio, COUNT(f.driver) AS num_violations
FROM humans h
JOIN facts f ON h.id = f.driver 
GROUP BY h.id, h.fio
HAVING COUNT(f.driver) = (SELECT MAX(num_driver) FROM 
	(SELECT COUNT(*) AS num_driver
	 FROM facts f 
	 GROUP BY driver)
);