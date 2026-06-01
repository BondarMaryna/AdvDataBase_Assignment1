CREATE VIEW customer_accounts_view AS
SELECT
    customers.customer_id,
    customers.first_name,
    customers.last_name,
    accounts.account_id,
    accounts.account_number,
    accounts.currency,
    accounts.balance,
    accounts.status
FROM customers
INNER JOIN accounts ON customers.customer_id = accounts.customer_id;

SELECT * FROM customer_accounts_view;


CREATE VIEW flagged_transactions_view AS
SELECT
    transaction_id,
    account_id,
    amount,
    currency,
    merchant_country,
    risk_score,
    status
FROM transactions
WHERE status = 'FLAGGED';

SELECT * FROM flagged_transactions_view;


CREATE VIEW fraud_alerts_view AS
SELECT
    fraud_alerts.alert_id,
    fraud_alerts.transaction_id,
    fraud_alerts.reason,
    fraud_alerts.risk_score,
    fraud_alerts.alert_status,
    transactions.amount,
    transactions.currency,
    transactions.merchant_country
FROM fraud_alerts
INNER JOIN transactions ON fraud_alerts.transaction_id = transactions.transaction_id;

SELECT * FROM fraud_alerts_view;
