-- Вывести к каждому самолету класс обслуживания
-- и количество мест этого класса

SELECT DISTINCT model, fare_conditions, count(*) FROM aircrafts_data
JOIN seats s on aircrafts_data.aircraft_code = s.aircraft_code
group by fare_conditions, model