CREATE TABLE GameTitle (
title TEXT NOT NULL,
release_year INTEGER NOT NULL,
platform TEXT NOT NULL,
price REAL NOT NULL,
PRIMARY KEY(release_year,platform,title)
);


CREATE TABLE GameLicense (
title TEXT NOT NULL,
release_year INTEGER NOT NULL,
platform TEXT NOT NULL,
license_id TEXT PRIMARY KEY CHECK(
--check 1: input is length 5
(LENGTH(license_id) == 5)
AND
--check 2: each character of input is valid integer 0-9
(SUBSTR(license_id,1,1) IN ('0','1','2','3','4','5','6','7','8','9') AND
SUBSTR(license_id,2,1) IN ('0','1','2','3','4','5','6','7','8','9') AND
SUBSTR(license_id,3,1) IN ('0','1','2','3','4','5','6','7','8','9') AND
SUBSTR(license_id,4,1) IN ('0','1','2','3','4','5','6','7','8','9') AND
SUBSTR(license_id,5,1) IN ('0','1','2','3','4','5','6','7','8','9'))
AND
--check 3: last character is valid (check digit)
(CAST(SUBSTR(license_id, 5,1) AS INTEGER) ==
SUBSTR((1*CAST(SUBSTR(license_id,1,1) AS INTEGER)) +
(3*CAST(SUBSTR(license_id,2,1) AS INTEGER)) +
(1*CAST(SUBSTR(license_id,3,1) AS INTEGER)) +
(3*CAST(SUBSTR(license_id,4,1) AS INTEGER)),-1,1)))
);


CREATE TABLE Gamer (
gamer_id INTEGER PRIMARY KEY,
first_name TEXT NOT NULL,
last_name TEXT NOT NULL,
email TEXT
);


CREATE TABLE gameRental (
gamer_id INTEGER NOT NULL,
license_id TEXT NOT NULL,
date_out TEXT NOT NULL,
date_back TEXT,
rental_cost REAL,
FOREIGN KEY (gamer_id) REFERENCES Gamer (gamer_id)
  ON UPDATE CASCADE,
FOREIGN KEY (license_id) REFERENCES GameLicense (license_id)
);