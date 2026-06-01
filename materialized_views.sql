CREATE MATERIALIZED VIEW fraud_dashboard AS
SELECT
    status,
    COUNT(*) AS transaction_count,
    AVG(risk_score) AS average_risk_score,
    SUM(amount) AS total_amount
FROM transactions
GROUP BY status;

SELECT * FROM fraud_dashboard;