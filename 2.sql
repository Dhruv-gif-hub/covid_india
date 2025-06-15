CREATE TABLE covid_vaccine_statewise(
    _Date_ Date,
    State VARCHAR(50),
    Total_Doses_Administered INT,
    Session_Completed INT,
    Sites INT,
    First_Dose_Administered INT,
    Second_Dose_Administered INT,
    Male_Doses_Administered INT,
    Female_Doses_Administered INT,
    Transgender_Doses_Administered INT,
    Covaxin_Doses_Administered INT,
    Covishield_Doses_Administered INT,
    Sputnik_V_Doses_Administered INT,
    AEFI INT,
    _18_44_Doses INT,
    _45_60_Doses INT,
    _60_plus_years_Doses INT,
    _18_44_years_Individuals_vaccinated INT,
    _45_60_years_Individuals_vaccinated INT,
    _60_plus_years_Individuals_vaccinated INT,
    Male_Individuals_vaccinated INT,
    Female_Individuals_vaccinated INT,
    Transgender_Individuals_vaccinated INT,
    Total_Individuals_vaccinated INT


)

 -- Importing data from CSV files into PostgreSQL tables on PGadmin 
COPY covid_vaccine_statewise FROM 'C:/Users/Dhruv/Desktop/Covid_India Project/archive/covid_vaccine_statewise.csv' WITH (FORMAT csv, HEADER true);

SELECT * FROM covid_vaccine_statewise;