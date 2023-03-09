Create database UK_Accidents;

use UK_Accidents;

create table accidents(
Accident_Index varchar(100),
Accident_Severity int,
Number_of_Vehicles int);

load data infile 
"D:/MySQL Assignment_2/UK Road Safty Accidents 2015/datasets/Accidents_2015.csv"
into table accidents
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(@col1, @dummy, @dummy, @dummy, @dummy, @dummy, @col2, @col3, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
set Accident_Index=@col1, Accident_Severity=@col2, Number_of_Vehicles=@col3;

create table Vehicles(
Accident_Index varchar (100),
Vehicle_Code int);

load data infile
"D:/MySQL Assignment_2/UK Road Safty Accidents 2015/datasets/Vehicles_2015.csv"
into table vehicles
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows
(@col1, @dummy, @col2, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy, @dummy)
set Accident_Index=@col1, Vehicle_Type=@col2;

Create table vehicle_types(
Vehicle_code int,
Vehicle_Type varchar(50));

load data infile
"D:/MySQL Assignment_2/UK Road Safty Accidents 2015/datasets/vehicle_types.csv"
into table vehicle_types
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;

/* 1.Evaluate the median severity value of accidents caused by various Motorcycles.*/

select avg(a.accident_severity) as 'Median Severity', vt.vehicle_type as 'Vehicle Type' from vehicle_types vt
join vehicles v on vt.vehicle_code = v.vehicle_code
join accidents a on v.accident_index = a.accident_index
where vehicle_type like '%Motorcycle%'
group by vehicle_type;

/* 2. Evaluate Accident Severity and Total Accidents per Vehicle Type */;

select a.accident_severity as 'Severity', count(v.accident_index) as 'Accidents', vt.vehicle_type as 'Vehicle Types'
from vehicles v
join accidents a on v.accident_index = a.accident_index
join vehicle_types vt on v.vehicle_code = vt.vehicle_code
group by 3
order by 2;

/* 3. Calculate the Average Severity by vehicle type. */

select avg(a.accident_severity) as 'Average Severity', vt.vehicle_type as 'Vehicle Type' from accidents a
join vehicles v on a.accident_index = v.accident_index
join vehicle_types vt on v.vehicle_code = vt.vehicle_code
group by 2 order by 2;


/* 4. Calculate the Average Severity and Total Accidents by Motorcycle. */

select avg(a.accident_severity) as 'Average Severity', vt.vehicle_type as 'Vehicle Type', count(vt.vehicle_type)
as 'Total Accidents' from accidents a
join vehicles v on a.accident_index = v.accident_index
join vehicle_types vt on v.vehicle_code = vt.vehicle_code
where vehicle_type like '%Motorcycle%'
group by 2 order by 2;