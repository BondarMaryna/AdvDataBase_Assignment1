CREATE OR REPLACE FUNCTION get_customer_age(
    p_customer_id BIGINT
)
RETURNS INT
AS $$
DECLARE
    customer_age INT;
BEGIN
    SELECT EXTRACT(YEAR FROM AGE(birth_date))
    INTO customer_age
    FROM customers
    WHERE customer_id = p_customer_id;

    RETURN customer_age;
END;
$$ LANGUAGE plpgsql;

SELECT get_customer_age(1);



CREATE OR REPLACE FUNCTION calculate_customer_daily_volume(
    p_customer_id BIGINT,
    p_date DATE
)
RETURNS DECIMAL(12,2)
AS $$
DECLARE
    total_volume DECIMAL(12,2);
BEGIN

    SELECT COALESCE(SUM(transactions.amount),0)
    INTO total_volume
    FROM transactions
    INNER JOIN accounts ON transactions.account_id = accounts.account_id
    WHERE accounts.customer_id = p_customer_id AND DATE(transactions.transaction_at) = p_date;

    RETURN total_volume;
END;
$$ LANGUAGE plpgsql;



SELECT calculate_customer_daily_volume(1,'2026-05-31');

CREATE OR REPLACE FUNCTION is_high_risk_country(
    p_country VARCHAR
)
RETURNS BOOLEAN
AS $$
BEGIN
    RETURN p_country IN ('RU', 'NG', 'IR');
END;
$$ LANGUAGE plpgsql;

SELECT is_high_risk_country('UK');