CREATE OR REPLACE PROCEDURE refresh_fraud_dashboard()
LANGUAGE plpgsql
AS $$
BEGIN
    REFRESH MATERIALIZED VIEW fraud_dashboard;
END
$$;

SELECT * FROM fraud_dashboard;

CALL update_transaction_status(1001,'APPROVED');

SELECT * FROM fraud_dashboard;

CALL refresh_fraud_dashboard();

SELECT * FROM fraud_dashboard;
