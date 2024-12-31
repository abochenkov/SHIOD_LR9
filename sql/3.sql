SELECT h.id, h.fio, SUM(v.payment) AS total_payment
FROM humans h
JOIN facts f ON h.id = f.driver
JOIN violations ON f.violation_id = v.id
GROUP BY h.id, h.fio
HAVING SUM(v.payment) > (SELECT AVG(total_payment) FROM (
    SELECT SUM(v.payment) AS total_payment
    FROM humans h
    JOIN facts f ON h.id = f.driver
    JOIN violations v ON f.violation_id = v.id
    GROUP BY h.id
    )
)
ORDER BY total_payment DESC; 