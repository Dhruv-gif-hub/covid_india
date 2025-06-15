CREATE DATABASE covid_india;



CREATE TABLE covid_India(
    Sno INT,
    _Date_ Date,
    _Time_ Time,
    State_UT VARCHAR(50),
    Confirmed_Indian_National INT,
    Confirmed_Foreign_National INT,
    Cured INT,
    Deaths INT,
    Confirmed INT
    )


 -- Importing data from CSV files into PostgreSQL tables on PGadmin 
COPY covid_India FROM 'C:/Users/Dhruv/Desktop/Covid_India Project/archive/covid_19_india.csv' WITH (FORMAT csv, HEADER true);

SELECT * FROM covid_India;