USE f1_db;

INSERT INTO PILOTO (driverId, driverRef, driverNumber, driverCode, forename, surname, dob, nationality, url)
VALUES (1, "hamilton", 44, "HAM", "Lewis", "Hamilton", "1985-01-07", "British", "http://en.wikipedia.org/wiki/Lewis_Hamilton");

INSERT INTO EQUIPO (constructorId, constructorRef, constructorName, nationality, url)
VALUES (1, "mclaren", "McLaren", "British", "http://en.wikipedia.org/wiki/McLaren");

INSERT INTO CIRCUITO (circuitId, circuitRef, circuitName, location, country, lat, lng, alt, url)
VALUES (1, "albert_park", "Albert Park Grand Prix Circuit", "Melbourne", "Australia", -37.8497, 144.968, 10, "http://en.wikipedia.org/wiki/Melbourne_Grand_Prix_Circuit");

INSERT INTO CARRERA (raceId, raceYear, raceRound, circuitId, raceName, raceDate, raceTime, url)
VALUES (1, 2009, 1, 1, "Australian Grand Prix", "2009-03-29", "06:00:00", "http://en.wikipedia.org/wiki/2009_Australian_Grand_Prix");

INSERT INTO RESULTADO (resultId, raceId, driverId, constructorId, grid, positionResult, points, laps, totalTime)
VALUES (1, 1, 1, 1, 1, 1, 10.00, 58, "1:34:15.784");

INSERT INTO CLASIFICACION (qualifyingId, raceId, driverId, constructorId, qualifyingPosition, q1, q2, q3)
VALUES (1, 1, 1, 1, 1, "1:26.572", "1:25.187", "1:24.202");

INSERT INTO INFO_CIRCUITO (circuitId, capacity, opened_year, length, turns)
VALUES (1, 125000, 1953, 5.027, 9);

INSERT INTO INFO_EQUIPO (constructorId, championships, race_wins, pole_positions, fastest_laps)
VALUES (1, 10, 203, 177, 183);