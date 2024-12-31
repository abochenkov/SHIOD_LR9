SELECT t.id, t.fio, t."date", t."name", t.payment, t.row_payment,
       SUM(SUM(t.payment)) OVER (PARTITION BY t.id ORDER BY t.id, t.row_payment ROWS UNBOUNDED PRECEDING) AS rolling_payment
FROM (
	SELECT h.id, h.fio, f."date", v."name", v.payment, 
  		   ROW_NUMBER() OVER (PARTITION BY h.id ORDER BY v.payment DESC) AS row_payment
	FROM humans h
	JOIN facts f ON h.id = f.driver 
	JOIN violations v ON f.violation_id = v.id 
	GROUP BY h.id, h.fio, f."date", v."name", v.payment 
	ORDER BY h.id, row_payment
) t
WHERE t.row_payment <= 3
GROUP BY t.id, t.fio, t."date", t."name", t.payment, t.row_payment