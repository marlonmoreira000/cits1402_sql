CREATE TRIGGER costCalculator AFTER UPDATE
ON gameRental
FOR EACH ROW
WHEN (NEW.rental_cost) IS NULL
BEGIN
  UPDATE gameRental
  SET rental_cost = 3
  --+ price
  + (SELECT gt.price
  FROM GameLicense gl INNER JOIN GameTitle gt
  ON gl.title = gt.title
  AND gl.release_year = gt.release_year
  AND gl.platform = gt.platform
  WHERE gl.license_id = NEW.license_id)
  --* 0.05
  * 0.05
  --* days rented
  * (SELECT JULIANDAY(NEW.date_back) - JULIANDAY(NEW.date_out))
  --make sure the calculated cost is put in the correct row
  WHERE gamer_id == NEW.gamer_id
  AND license_id == NEW.license_id
  AND date_out == NEW.date_out;
END;