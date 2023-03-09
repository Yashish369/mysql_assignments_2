create database World_Population;

use World_Population;

create table population_data(
`Country` varchar (45),
`Area` int,
`Birth_rate` decimal (50,2),
`Death_rate` decimal (50,2),
`Infant_mortality_rate` decimal (50,2),
`Internet_users` int,
`Life_exp_at_birth` decimal (50,2),
`Maternal_mortality_rate` int,
`Net_migration_rate` decimal (50,2),
`Population` int,
`Population_growth_rate` decimal (50,2));


load data infile
"D:\cia_factbook.csv"
into table population_data
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


select * from population_data;

/* 1. Which country has the highest population? */

select Country, Population from population_data where population = (select max(population) from population_data);

/* 2. Which country has the least number of people? */

select Country, Population from population_data where population = (select min(population) from population_data
where population > (select min(population) from population_data));


/* 3. Which country is witnessing the highest population growth? */

select Country, Population_Growth_Rate from population_data 
where Population_Growth_Rate = (select max(Population_Growth_Rate) from population_data);


/* 4. Which country has an extraordinary number for the population? (This Question is not clear, what kind of extraordinary number is required ? */

select country, population from population_data where population like '1%9';
/* To answer this assignment question no.4 is that there are 3 countries whose population number starts with 1 and ends with 9. These are some extraordinary number for the population.


/* 5. Which is the most densely populated country in the world? */

alter table population_data
add column Population_Density decimal (10,2);

update population_data
set Population_Density = population/area;

select Country, Population_Density from population_data 
where Population_Density = (select max(Population_Density) from population_data);