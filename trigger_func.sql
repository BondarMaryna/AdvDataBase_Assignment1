CREATE OR REPLACE FUNCTION create_fraud_alert_trigger()
RETURNS TRIGGER
AS $$
BEGIN

    IF NEW.status = 'FLAGGED' THEN

        INSERT INTO fraud_alerts (
            alert_id,
            transaction_id,
            rule_id,
            reason,
            risk_score,
            alert_status,
            created_at
        )
        VALUES (
            (SELECT COALESCE(MAX(alert_id),0) + 1 FROM fraud_alerts),
            NEW.transaction_id,
            1,
            'Flagged transaction',
            NEW.risk_score,
            'OPEN',
            CURRENT_TIMESTAMP
        );

    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;