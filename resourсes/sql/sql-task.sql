-- Вывести к каждому самолету класс обслуживания
-- и количество мест этого класса

SELECT DISTINCT model, fare_conditions, count(*) FROM aircrafts_data a
JOIN seats s ON a.aircraft_code = s.aircraft_code
GROUP BY model, fare_conditions;

-- Найти 3 самых вместительных самолета (модель + кол-во мест)

SELECT DISTINCT model, count(*) AS number_of_seats FROM aircrafts_data a
JOIN seats s ON a.aircraft_code = s.aircraft_code
GROUP BY model
ORDER BY number_of_seats DESC
LIMIT 3;

-- Вывести код,модель самолета и места не эконом класса
-- для самолета 'Аэробус A321-200' с сортировкой по местам

SELECT DISTINCT a.aircraft_code, model, seat_no FROM aircrafts_data a
JOIN seats s ON a.aircraft_code = s.aircraft_code
WHERE model->>'ru' LIKE '%Аэробус A321-200%' AND fare_conditions NOT LIKE '%Economy%'
ORDER BY seat_no;

-- Вывести города в которых больше 1 аэропорта ( код аэропорта, аэропорт, город)

SELECT city, count(*) FROM airports_data
GROUP BY city
HAVING count(*) > 1;

-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву,
-- на который еще не завершилась регистрация

SELECT * FROM flights_v
WHERE departure_city LIKE '%Екатеринбург%'
  AND arrival_city LIKE '%Москва%'
  AND status LIKE '%Scheduled%'
ORDER BY scheduled_departure_local
LIMIT 1;


