CREATE TRIGGER trigger_create_fraud_alert
AFTER UPDATE OF status
ON transactions
FOR EACH ROW
EXECUTE FUNCTION create_fraud_alert_trigger();