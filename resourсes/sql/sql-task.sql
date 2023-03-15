--Вывести к каждому самолету класс обслуживания
--и количество мест этого класса

SELECT DISTINCT model, fare_conditions, count(*) FROM aircrafts_data a
JOIN seats s on a.aircraft_code = s.aircraft_code
group by model, fare_conditions;

--Найти 3 самых вместительных самолета (модель + кол-во мест)

SELECT DISTINCT model, count(*) as number_of_seats FROM aircrafts_data a
JOIN seats s on a.aircraft_code = s.aircraft_code
group by model
order by number_of_seats DESC
limit 3;

--Вывести код,модель самолета и места не эконом класса
--для самолета 'Аэробус A321-200' с сортировкой по местам

SELECT DISTINCT a.aircraft_code, model, seat_no FROM aircrafts_data a
JOIN seats s on a.aircraft_code = s.aircraft_code
WHERE model->>'ru' LIKE '%Аэробус A321-200%' AND fare_conditions NOT LIKE '%Economy%'
order by seat_no;


