CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50) UNIQUE,
    birth_date DATE,
    country_code VARCHAR(5),
    created_at TIMESTAMP,
    is_active BOOLEAN
);

CREATE TABLE audit_log (
    audit_id BIGINT PRIMARY KEY,
    customer_id BIGINT,
    table_name VARCHAR(50),
    operation VARCHAR(20),
    old_value JSON,
    new_value JSON,
    changed_at TIMESTAMP,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE accounts (
    account_id BIGINT PRIMARY KEY,
    customer_id BIGINT,
    account_number VARCHAR(30) UNIQUE,
    currency VARCHAR(3),
    balance DECIMAL(12,2),
    status VARCHAR(20),
    opened_at TIMESTAMP,

    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE cards (
    card_id BIGINT PRIMARY KEY,
    account_id BIGINT,
    card_number_hash VARCHAR(255) UNIQUE,
    card_type VARCHAR(20),
    status VARCHAR(20),
    expiration_date DATE,

    FOREIGN KEY (account_id) REFERENCES accounts(account_id)
);

CREATE TABLE transactions (
    transaction_id BIGINT PRIMARY KEY,
    account_id BIGINT,
    card_id BIGINT,
    amount DECIMAL(12,2),
    currency VARCHAR(3),
    merchant_category VARCHAR(100),
    merchant_country VARCHAR(100),
    status VARCHAR(20),
    risk_score INT,
    transaction_at TIMESTAMP,
    created_at TIMESTAMP,

    FOREIGN KEY (account_id) REFERENCES accounts(account_id),
    FOREIGN KEY (card_id) REFERENCES cards(card_id)
);

CREATE TABLE transaction_status_history (
    history_id BIGINT PRIMARY KEY,
    transaction_id BIGINT,
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    changed_at TIMESTAMP,
    changed_by VARCHAR(50),

    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id)
);

CREATE TABLE fraud_rules (
    rule_id BIGINT PRIMARY KEY,
    rule_name VARCHAR(100),
    rule_type VARCHAR(50),
    threshold_value INT,
    is_active BOOLEAN
);

CREATE TABLE fraud_alerts (
    alert_id BIGINT PRIMARY KEY,
    transaction_id BIGINT,
    rule_id BIGINT,
    reason VARCHAR(255),
    risk_score INT,
    alert_status VARCHAR(20),
    created_at TIMESTAMP,

    FOREIGN KEY (transaction_id) REFERENCES transactions(transaction_id),
    FOREIGN KEY (rule_id) REFERENCES fraud_rules(rule_id)
);

