ALTER TABLE transactions
ADD CONSTRAINT check_amount
CHECK (amount > 0);

ALTER TABLE accounts
ADD CONSTRAINT check_balance
CHECK (balance >= 0);

ALTER TABLE accounts
ADD CONSTRAINT check_account_currency
CHECK (currency IN ('UAH', 'USD', 'EUR'));

ALTER TABLE transactions
ADD CONSTRAINT check_transaction_currency
CHECK (currency IN ('UAH', 'USD', 'EUR'));

ALTER TABLE transactions
ADD CONSTRAINT check_transaction_status
CHECK (status IN ('PENDING', 'APPROVED', 'DECLINED', 'FLAGGED'));