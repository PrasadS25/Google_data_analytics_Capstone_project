CREATE DATABASE gda;
USE gda;
DROP TABLE test;
CREATE TABLE test(
	ride_id	VARCHAR(25) PRIMARY KEY,
    rideable_type	varchar(15),
    started_at	DATETIME,
    ended_at	DATETIME,
    start_station_name	TEXT,
    start_station_id	TEXT,
    end_station_name	TEXT,
    end_station_id	TEXT,
    member_casual	varchar(20),
    ride_length	TIME,
    day_of_week int
);

CREATE TABLE temp_rides (
    ride_id TEXT,
    rideable_type VARCHAR(15),
    started_at VARCHAR(20),
    ended_at VARCHAR(20),
    start_station_name	TEXT,
    start_station_id	TEXT,
    end_station_name	TEXT,
    end_station_id	TEXT,
    start_lat TEXT,
    start_lng TEXT,
    end_lat TEXT,
    end_lng TEXT,
    member_casual VARCHAR(20),
    day_of_week INT
);
drop table temp_rides;



SHOW VARIABLES LIKE 'secure_file_priv';


LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/202405-divvy-tripdata-cleaned.csv'
INTO TABLE temp_rides
FIELDS TERMINATED BY ','
ENCLOSED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


CREATE TABLE rides (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10, 6),
    start_lng DECIMAL(10, 6),
    end_lat DECIMAL(10, 6),
    end_lng DECIMAL(10, 6),
    member_casual VARCHAR(255),
    ride_length TIME,
    day_of_week INT
);
DROP TABLE rides;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/cleaned_202306-divvy-tripdata.csv'
INTO TABLE rides
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual, @ride_length_str, day_of_week)
SET ride_length = SEC_TO_TIME(TIME_TO_SEC(@ride_length_str));

SELECT rideable_type,COUNT(*) 
FROM rides
GROUP BY rideable_type;

SELECT ended_at-started_at as duaration
FROM rides
LIMIT 100;

-- Full year table
USE gda;
-- DROP table full_year;  

CREATE TABLE full_year (
    ride_id VARCHAR(255),
    rideable_type VARCHAR(255),
    started_at DATETIME,
    ended_at DATETIME,
    start_station_name VARCHAR(255),
    start_station_id VARCHAR(255),
    end_station_name VARCHAR(255),
    end_station_id VARCHAR(255),
    start_lat DECIMAL(10, 6),
    start_lng DECIMAL(10, 6),
    end_lat DECIMAL(10, 6),
    end_lng DECIMAL(10, 6),
    member_casual VARCHAR(255),
    ride_length TIME,
    day_of_week INT
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.1/Uploads/full_year_combined.csv'
INTO TABLE full_year
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(ride_id, rideable_type, started_at, ended_at, start_station_name, start_station_id, end_station_name, end_station_id, start_lat, start_lng, end_lat, end_lng, member_casual, @ride_length_str, day_of_week)
SET ride_length = SEC_TO_TIME(TIME_TO_SEC(@ride_length_str));


SELECT COUNT(*)
FROM full_year
LIMIT 100;


CREATE TABLE rides202306 LIKE full_year;
