CREATE OR REPLACE PROCEDURE freeze_account(
    p_account_id BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE accounts
    SET status = 'FROZEN'
    WHERE account_id = p_account_id;
END;
$$;

CALL freeze_account(101);

SELECT *
FROM accounts
WHERE account_id = 101;


CREATE OR REPLACE PROCEDURE activate_account(
    p_account_id BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE accounts
    SET status = 'ACTIVE'
    WHERE account_id = p_account_id;
END;
$$;

CALL activate_account(101);

SELECT *
FROM accounts
WHERE account_id = 101;


CREATE OR REPLACE PROCEDURE update_transaction_status(
    p_transaction_id BIGINT,
    p_new_status VARCHAR(20)
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE transactions
    SET status = p_new_status
    WHERE transaction_id = p_transaction_id;
END;
$$;

CALL update_transaction_status(1006,'APPROVED');

SELECT
    transaction_id,
    status
FROM transactions
WHERE transaction_id = 1006;



