CREATE DATABASE "Ojek";

CREATE TABLE IF NOT exists "Customer" (
    "id" serial primary key,
    "name" VARCHAR,
    "status" BOOLEAN,
    "createdAt" DATE NOT NULL
);
CREATE TABLE IF NOT exists "Driver" (
    "id" serial primary key,
    "name" VARCHAR,
    "status" BOOLEAN,
    "createdAt" DATE NOT NULL
);
CREATE TABLE IF NOT exists "Order" (
    "id" serial primary key,
    "driver_id" INT NOT NULL REFERENCES "Driver"("id"),
    "customer_id" INT NOT NULL REFERENCES "Customer"("id"),
    "daerah" VARCHAR,
    "createdAt" TIMESTAMP NOT NULL
);

insert into "Customer" ("name", "status" , "createdAt")
values
	('customer1', true, '2021-03-03'),
	('customer2', true, '2021-08-03'),
	('customer3', true, '2021-08-03'),
	('customer4', false, '2021-03-03'),
	('customer5', false, '2021-03-03');
	
insert into "Driver" ("name", "status" , "createdAt")
values
	('driver1', false, '2021-03-03'),
	('driver2', false, '2021-08-03'),
	('driver3', false, '2021-08-03'),
	('driver4', true, '2021-03-03'),
	('driver5', true, '2021-03-03');
	
    
insert into "Order" ("driver_id" , "customer_id", "daerah"  , "createdAt")
values
	(2, 1, 'Jakarta', '2024-10-03 10:00:00'),
	(2, 2, 'Jakarta', '2024-10-05 10:00:00'),
	(2, 2, 'Jakarta', '2024-10-06 11:00:00'),
	(4, 2, 'Jakarta', '2024-10-07 11:30:00'),
	(1, 3, 'Jakarta', '2024-10-05 18:00:00'),
	(3, 4, 'Jogja', '2024-10-09 11:00:00'),
	(4, 2, 'Jakarta', '2024-10-15 12:30:00'),
	(5, 5, 'Depok', '2024-10-20 13:00:00'),
	(1, 1, 'Jakarta', '2024-10-21 15:00:00'),
	(4, 5, 'Depok', '2024-10-23 18:30:00'),
	(5, 5, 'Depok', '2024-10-03 14:00:00');
	


select count("createdAt") as "total order tiap bulan"
from "Order" o 
where date_part ('month', o."createdAt") = 10;


select c."name", t."total_orders"
from "Customer" c
join (
	SELECT o."customer_id",
    	count(*) AS total_orders
	FROM "Order" o
	WHERE 
    	date_part ('month', o."createdAt") = 10
    	and date_part ('year', o."createdAt") = 2024
	GROUP BY 
    	o."customer_id" 
	ORDER BY 
    	total_orders desc) t
on c."id" = t."customer_id";


select  o."daerah",
	count(*) AS total_orders
from "Order" o
where  
	date_part ('month', o."createdAt") = 10
	and date_part ('year', o."createdAt") = 2024
group  by  
	o."daerah" 
order  by 
	total_orders desc


select count(c."status") as "customer online",
	(select count(c."status") as "customer offline"
	from "Customer" c
	where c."status" = false)
from "Customer" c
where c."status" = true;

	
select d."name", t."total_orders"
from "Driver" d
join (
	SELECT o."driver_id",
    	COUNT(*) AS total_orders
	FROM "Order" o
	WHERE 
    	date_part ('month', o."createdAt") = 10
    	and date_part ('year', o."createdAt") = 2024
	GROUP BY 
    	o."driver_id" 
	ORDER BY 
    	total_orders desc) t
on d."id" = t."driver_id";


select date_part ('hour', o."createdAt") as "jam order",
	count(*) AS "total orders"
from "Order" o
where  
	date_part ('month', o."createdAt") = 10
	and date_part ('year', o."createdAt") = 2024
group  by 
	date_part ('hour', o."createdAt")
order  by 
	"total orders" desc;