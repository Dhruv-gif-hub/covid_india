CREATE TABLE Statewise_Testing_details(
    _Date_ Date,
    _State_ VARCHAR(100),
    Total_Samples INT,
    Negative INT,
    Positive INT

)

 -- Importing data from CSV files into PostgreSQL tables on PGadmin 
COPY Statewise_Testing_details FROM 'C:/Users/Dhruv/Desktop/Covid_India Project/archive/StatewiseTestingDetails.csv' WITH (FORMAT csv, HEADER true, NULL " ");

SELECT * FROM Statewise_Testing_details;


