
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
