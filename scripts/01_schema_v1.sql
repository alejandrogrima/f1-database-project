DROP DATABASE IF EXISTS f1_db;
CREATE DATABASE f1_db;

use f1_db;

# Tabla de Piloto
CREATE TABLE PILOTO (
	driverId INT PRIMARY KEY,
    driverRef VARCHAR(50),
    driverNumber INT,
    driverCode VARCHAR(3),
    forename VARCHAR(50),
    surname VARCHAR(50),
    dob DATE,
    nationality VARCHAR(50),
    URL VARCHAR(255)
    );
    
#Tabla de Equipo
CREATE TABLE EQUIPO(
	constructorId INT PRIMARY KEY,
    constructorRef VARCHAR(50),
    constructorName VARCHAR(70),
    nationality VARCHAR(50),
    url VARCHAR(255)
    );
    
#Tabla de Circuito
CREATE TABLE CIRCUITO(
	circuitId INT PRIMARY KEY,
    circuitRef VARCHAR(50),
    circuitName VARCHAR(70),
    location VARCHAR(50),
    country VARCHAR(50),
    lat DECIMAL(10, 6),
    lng DECIMAL(10, 6),
    alt INT,
    url VARCHAR(255)
    );

#Tabla de Carrera    
CREATE TABLE CARRERA(
	raceId INT PRIMARY KEY,
    raceYear INT,
    raceRound INT,
    circuitId INT,
    FOREIGN KEY (circuitId) REFERENCES CIRCUITO(circuitId),
    raceName VARCHAR(50),
    raceDate DATE,
    raceTime TIME,
    url VARCHAR(255)
    );
    
#Tabla de Resultado
CREATE TABLE RESULTADO(
	resultId INT PRIMARY KEY,
    raceId INT,
    FOREIGN KEY (raceId) REFERENCES CARRERA(raceId),
    driverId INT,
    FOREIGN KEY (driverId) REFERENCES PILOTO(driverId),
    constructorId INT,
	FOREIGN KEY (constructorId) REFERENCES EQUIPO(constructorId),
    grid INT,
    positionResult INT,
    points DECIMAL(6,2),
    laps INT,
    totalTime VARCHAR(50)
    );
    
#Tabla de Clasificación
CREATE TABLE CLASIFICACION(
	qualifiyingId INT PRIMARY KEY,
	raceId INT,
	FOREIGN KEY (raceId) REFERENCES CARRERA(raceId),
    driverId INT,
    FOREIGN KEY (driverId) REFERENCES PILOTO(driverId),
    constructorId INT,
	FOREIGN KEY (constructorId) REFERENCES EQUIPO(constructorId),
	qualifiyingPosition INT,
    q1 VARCHAR(50),
    q2 VARCHAR(50),
    q1 VARCHAR(50)
    );
    
#Tabla de la info scrapeada

    
    