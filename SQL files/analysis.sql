#Full year data analysis
USE Gda;

SELECT COUNT(*) as Total_Rows
FROM full_year
LIMIT 100;

SELECT *
FROM full_year
LIMIT 10;

#Average ride length by rideable_type
SELECT rideable_type, TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') AS Average_ride
FROM full_year
GROUP BY rideable_type;

SELECT rideable_type, (COUNT(ride_length)) AS COUNTS
FROM full_year
GROUP BY rideable_type;

SELECT member_casual, TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as Average_Ride
FROM full_year
GROUP BY member_casual;

#Grouping by day of week
SELECT day_of_week, TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as Average_ride
FROM full_year
GROUP BY day_of_week;

SELECT day_of_week,member_casual, TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as Average_ride
FROM full_year
GROUP BY day_of_week,member_casual
ORDER BY day_of_week, member_casual;
-- Ops done

#Grouping by the Month
SELECT DATE_FORMAT(started_at,'%m') as Month,member_casual, TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as Average_ride
FROM full_year
GROUP BY DATE_FORMAT(started_at,'%m'), member_casual;
-- Months Nov, Dec and jan seem have have less ride lengths.

#grouping by day of month
SELECT dayofmonth(started_at) as 'Day of Month',member_casual, TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as Average_ride
FROM full_year
GROUP BY dayofmonth(started_at), member_casual;

SELECT DATE_FORMAT(started_at,'%Y-%m-%d') AS Day , TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as Average_ride
FROM full_year
GROUP BY DATE_FORMAT(started_at,'%Y-%m-%d')
ORDER BY TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') DESC 
LIMIT 10;

SELECT member_casual,rideable_type, (COUNT(rideable_type)/(SELECT COUNT(*) FROM full_year)) *100 AS 'Percent of Rides'
FROM full_year
GROUP BY member_casual,rideable_type;

SELECT member_casual, ROUND((COUNT(ride_length)/(SELECT COUNT(*) FROM full_year)) * 100,2) AS 'Percent of Rides'
FROM full_year
GROUP BY member_casual;

SELECT member_casual, TIME_FORMAT(SEC_TO_TIME(MIN(ride_length)),'%H:%i:%s') as 'Min ride', TIME_FORMAT(SEC_TO_TIME(MAX(ride_length)),'%H:%i:%s') AS 'Max ride', TIME_FORMAT(SEC_TO_TIME(AVG(ride_length)),'%H:%i:%s') as 'Mean ride'
FROM full_year
GROUP BY member_casual;

SELECT max(ride_length) FROM full_year;




