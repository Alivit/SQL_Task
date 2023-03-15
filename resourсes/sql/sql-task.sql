-- Вывести к каждому самолету класс обслуживания
-- и количество мест этого класса

SELECT model ->>'ru' AS model_ru, fare_conditions, count(*)
  FROM aircrafts_data AS ad
       INNER JOIN seats AS s
       ON ad.aircraft_code = s.aircraft_code
GROUP BY model, fare_conditions;

-- Найти 3 самых вместительных самолета (модель + кол-во мест)

SELECT model ->>'ru' AS model_ru, count(*) AS number_of_seats
  FROM aircrafts_data AS ad
       INNER JOIN seats AS s
       ON ad.aircraft_code = s.aircraft_code
GROUP BY model
ORDER BY number_of_seats DESC
LIMIT 3;

-- Вывести код,модель самолета и места не эконом класса
-- для самолета 'Аэробус A321-200' с сортировкой по местам

SELECT ad.aircraft_code, model ->>'ru' AS model_ru, seat_no
  FROM aircrafts_data AS ad
       INNER JOIN seats AS s
       ON ad.aircraft_code = s.aircraft_code
WHERE model->>'ru' LIKE '%Аэробус A321-200%'
  AND fare_conditions NOT LIKE '%Economy%'
ORDER BY seat_no;

-- Вывести города в которых больше 1 аэропорта ( код аэропорта, аэропорт, город)

SELECT city, count(*)
  FROM airports_data
GROUP BY city
HAVING count(*) > 1;

-- Найти ближайший вылетающий рейс из Екатеринбурга в Москву,
-- на который еще не завершилась регистрация

SELECT *
  FROM flights_v
 WHERE departure_city LIKE '%Екатеринбург%'
   AND arrival_city LIKE '%Москва%'
   AND status LIKE '%Scheduled%'
ORDER BY scheduled_departure_local
 LIMIT 1;

-- Вывести самый дешевый и дорогой билет и стоимость ( в одном результирующем ответе)

SELECT *
  FROM ticket_flights
ORDER BY amount
 LIMIT 1;
 UNION
SELECT *
  FROM ticket_flights
ORDER BY amount DESC
 LIMIT 1;

-- Написать DDL таблицы Customers , должны быть поля id , firstName, LastName, email , phone.
-- Добавить ограничения на поля ( constraints).

CREATE TABLE IF NOT EXISTS Customers (
        id bigserial PRIMARY KEY,
        firstName text NOT NULL,
        lastName text NOT NULL,
        email varchar(50) NOT NULL UNIQUE check ( email LIKE '%@%'),
        phone varchar(20) NOT NULL UNIQUE check ( phone LIKE '+%')
);

-- Написать DDL таблицы Orders , должен быть id, customerId, quantity.
-- Должен быть внешний ключ на таблицу customers + ограничения

CREATE TABLE IF NOT EXISTS Orders (
        id bigserial PRIMARY KEY,
        customerId int NOT NULL,
        quantity numeric(10,5) NOT NULL,
        FOREIGN KEY (customerId) references bookings.customers(id)
);