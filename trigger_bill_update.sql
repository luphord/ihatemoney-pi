CREATE TABLE IF NOT EXISTS bill_archive (
    change_type TEXT,
    change_time DATETIME,
	id INTEGER NOT NULL, 
	payer_id INTEGER, 
	amount FLOAT, 
	date DATE, 
	what TEXT, 
	archive INTEGER, creation_date DATE
);

CREATE TRIGGER IF NOT EXISTS update_bill AFTER UPDATE ON bill
  BEGIN
    INSERT INTO bill_archive VALUES ('update', datetime('now'), old.id, old.payer_id, old.amount, old.date, old.what, old.archive, old.creation_date);
  END;

CREATE TRIGGER IF NOT EXISTS delete_bill AFTER DELETE ON bill
  BEGIN
    INSERT INTO bill_archive VALUES ('delete', datetime('now'), old.id, old.payer_id, old.amount, old.date, old.what, old.archive, old.creation_date);
  END;
