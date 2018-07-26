
DROP PROCEDURE IF EXISTS get_puzzle_pieces;

CREATE PROCEDURE get_puzzle_pieces()
SELECT
  puzzle_piece_id,
  price,
  is_available,
  last_update,
  employer_and_occupation,
  paypal_payment_id,
  first_name,
  last_name,
  comments
FROM puzzle_pieces;


DROP PROCEDURE IF EXISTS get_puzzle_piece;

CREATE PROCEDURE get_puzzle_piece(IN in_puzzle_piece_id INT)
SELECT
  puzzle_piece_id,
  price,
  is_available,
  last_update,
  employer_and_occupation,
  paypal_payment_id,
  first_name,
  last_name,
  comments
FROM puzzle_pieces
WHERE puzzle_piece_id = in_puzzle_piece_id;


DROP PROCEDURE IF EXISTS update_puzzle_piece;

CREATE PROCEDURE update_puzzle_piece(
  IN in_puzzle_piece_id INT,
  IN new_is_available TINYINT(1),
  IN new_employer_and_occupation VARCHAR(64),
  IN new_paypal_payment_id VARCHAR(32),
  IN new_first_name VARCHAR(32),
  IN new_last_name VARCHAR(32),
  IN new_comments VARCHAR(1024)
)
UPDATE puzzle_pieces
SET
  is_available = new_is_available,
  employer_and_occupation = new_employer_and_occupation,
  paypal_payment_id = new_paypal_payment_id,
  first_name = new_first_name,
  last_name = new_last_name,
  comments = new_comments
WHERE puzzle_piece_id = in_puzzle_piece_id;

DROP PROCEDURE IF EXISTS buy_puzzle_piece;

CREATE PROCEDURE buy_puzzle_piece(
  IN in_puzzle_piece_id INT,
  IN new_employer_and_occupation VARCHAR(64),
  IN new_paypal_payment_id VARCHAR(32),
  IN new_first_name VARCHAR(32),
  IN new_last_name VARCHAR(32)
)
UPDATE puzzle_pieces
SET
  is_available = 0,
  employer_and_occupation = new_employer_and_occupation,
  paypal_payment_id = new_paypal_payment_id,
  first_name = new_first_name,
  last_name = new_last_name
WHERE puzzle_piece_id = in_puzzle_piece_id;
