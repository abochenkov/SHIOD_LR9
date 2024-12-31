SELECT h.id, h.fio, f."date", SUM(v.payment) AS total_payment,
  SUM(SUM(v.payment)) OVER (PARTITION BY h.id ORDER BY h.id, f."date" ROWS UNBOUNDED PRECEDING) AS rolling_age_sum
FROM humans h
JOIN facts f ON h.id = f.driver
JOIN violations v ON f.violation_id = v.id
GROUP BY h.id, h.fio, f."date"
ORDER BY 1, 3;  