CREATE VIEW GamerRentalSummary AS
  SELECT 
  g.gamer_id AS gamer_id,
  (g.first_name || ' ' || g.last_name) AS gamer_name,
  gl.title AS game_title,
  gl.release_year AS game_release_year,
  gl.platform AS game_platform,
  COUNT(*) AS times_rented,
  PRINTF("%.2f", ROUND(SUM(gr.rental_cost), 2)) AS total_rental_cost
  FROM Gamer g
  INNER JOIN gameRental gr ON g.gamer_id = gr.gamer_id
  INNER JOIN GameLicense gl ON gr.license_id = gl.license_id
  WHERE gr.date_back IS NOT NULL
  GROUP BY g.gamer_id, gl.license_id;