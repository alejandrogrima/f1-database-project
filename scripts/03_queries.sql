use f1_db;

#1: Países en los que ha habido más carreras
SELECT c.country, count(*) as total_carreras
FROM CARRERA ca 
INNER JOIN CIRCUITO c on ca.circuitId = c.circuitId
GROUP BY c.country
ORDER BY total_carreras DESC;

#2: Número de pilotos por país
SELECT nationality, count(*) as total_pilotos
FROM PILOTO
GROUP BY nationality
ORDER BY total_pilotos DESC;

#3: Victorias por piloto
SELECT p.surname, count(*) as victorias_piloto
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
WHERE positionResult = 1
GROUP BY p.driverId
ORDER BY victorias_piloto DESC;

#4: Victorias (de pilotos) por país
SELECT p.nationality, count(*) as victorias_pais
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
WHERE positionResult = 1
GROUP BY p.nationality
ORDER BY  victorias_pais DESC;

#5: Victorias de pilotos españoles
# Esta la hago porque me ha llamado la atención el número de victorias de españoles
SELECT p.surname, p.nationality, count(*) as victorias_piloto
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
WHERE positionResult = 1 and p.nationality = "Spanish"
GROUP BY p.driverID
ORDER BY victorias_piloto DESC;
#Se me había olvidado completamente la existencia de Carlos Sainz

#6: Número de carreras por circuito
SELECT ci. circuitName, count(*) as total_carreras
FROM  CIRCUITO ci 
INNER JOIN  CARRERA ca on ci.circuitId = ca.circuitId
GROUP BY ci.circuitId
ORDER BY total_carreras DESC;

#7 Pilotos con más de 100 podios
SELECT p.surname, count(*) as total_podios
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
WHERE r.positionResult = 1
	or r.positionResult = 2
    or r.positionResult = 3
GROUP BY p.driverId
HAVING total_podios > 100
ORDER BY total_podios DESC;

#8: Equipos con más de 100 victorias 
SELECT e.constructorName, count(*) as victorias
FROM RESULTADO r
INNER JOIN  EQUIPO e on r.constructorId = e.constructorID
where positionResult = 1
GROUP BY e.constructorId, e.constructorName
HAVING  victorias > 100
ORDER BY victorias DESC;

#9: Número de carreras por año
SELECT raceYear, count(*) as total_carreras
FROM CARRERA
GROUP BY raceYear
ORDER BY raceYear DESC;

#10: Promedio de puntos por carrera de cada piloto
SELECT p.surname, AVG(r.points) as promedio_puntos
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
GROUP BY p.driverId
ORDER BY promedio_puntos DESC;

# Esta la voy a hacer tambien unicamente desde 2010
# ya que cambió el sistema de puntos en 2010

#10.1 Promedio de puntos por carrera de cada piloto desde 2010(incluido)
SELECT p.surname, AVG(r.points) as promedio_puntos
FROM PILOTO  p
INNER JOIN RESULTADO r on p.driverId = r.driverId
INNER JOIN CARRERA c on r.raceId = c.raceId
WHERE  c.raceYear >= 2010
GROUP BY  p.driverId
ORDER BY promedio_puntos DESC;

#11: Número de vueltas(en total) por piloto
SELECT p.surname, sum(r.laps) as total_vueltas
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
GROUP BY p.driverId
ORDER BY total_vueltas DESC;

#12: Número de temporadas por equipo
SELECT e.constructorName, count(distinct c.raceYear) as total_temporadas
FROM CARRERA c
INNER JOIN  RESULTADO r on c.raceId = r.raceId
INNER JOIN EQUIPO e on r.constructorid = e.constructorId
GROUP BY r.constructorId
ORDER BY total_temporadas DESC;

#13: Carreras donde el ganador es español
SELECT c.raceName, c.raceYear, p.surname
FROM CARRERA c
INNER JOIN RESULTADO r on c.raceId = r.RaceId
INNER JOIN PILOTO p on r.driverId = p.driverId
WHERE r.positionResult = 1
AND  p.driverId IN(
	SELECT driverId
    FROM PILOTO
    WHERE nationality = "Spanish"
    );
    
#14: Pilotos con más victorias que la media
WITH victorias_por_piloto as (
	SELECT driverId, count(*) as victorias
    FROM RESULTADO
    WHERE positionResult = 1
    GROUP BY driverId
    )
SELECT p.surname, v.victorias
FROM victorias_por_piloto v
INNER JOIN PILOTO p on v.driverId = p.driverId
WHERE v.victorias >(
	SELECT avg(victorias)
    FROM  victorias_por_piloto
    )
ORDER BY v.victorias DESC;

#15: Puntos totales por piloto
SELECT p.surname, sum(r.points) as total_puntos,
		ROW_NUMBER() OVER(ORDER BY sum(r.points) DESC) as ranking
FROM RESULTADO r 
INNER JOIN PILOTO p on r.driverId = p.driverId
GROUP BY p.driverId;

#16: Estadisticas de pilotos
CREATE VIEW EstadisticasPiloto as
SELECT p.surname,
       p.nationality,
       count(*) as num_carreras,
       sum(r.points) as puntos_totales,
       sum(case when r.positionResult = 1 then 1 else 0 end) as victorias,
       sum(case when r.positionResult = 1
					or positionResult = 2
                    or positionResult = 3
                    then 1 else 0 end) as podios
FROM PILOTO p
INNER JOIN RESULTADO r on p.driverId = r.driverId
GROUP BY p.driverId;

SELECT *
FROM EstadisticasPiloto 
ORDER BY victorias DESC
LIMIT 15;

#17: Estadisticas de equipos
CREATE VIEW EstadisticasEquipo as
SELECT e.constructorName,
       e.nationality,
       count(*) as carreras,
       sum(r.points) as puntos_totales,
       sum(case when r.positionResult = 1 then 1 else 0 end) as victorias,
       sum(case when r.positionResult = 1
					or positionResult = 2
                    or positionResult = 3
                    then 1 else 0 end) as podios
FROM EQUIPO e
INNER JOIN RESULTADO r on e.constructorId = r.constructorId
GROUP BY e.constructorId;

SELECT *
FROM EstadisticasEquipo
ORDER BY podios DESC
LIMIT 10;

#18: Circuitos con más de 15 curvas
SELECT c.circuitName, c.country, ic.turns
FROM CIRCUITO c
INNER JOIN INFO_CIRCUITO ic ON c.circuitId = ic.circuitId
WHERE ic.turns > 15
ORDER BY ic.turns DESC;

#19 Equipos que han ganado campeonatos de constructores
SELECT 
    e.constructorName,
    e.nationality,
    ie.championships
FROM EQUIPO e
INNER JOIN INFO_EQUIPO ie ON e.constructorId = ie.constructorId
WHERE ie.championships > 0
ORDER BY ie.championships DESC;






