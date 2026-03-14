select * from maindata;

SELECT 
COUNT(DISTINCT `%Airline ID`) AS total_airlines ,
COUNT(DISTINCT `origin country`) AS total_country,
COUNT(DISTINCT `origin city`) AS total_city,
count(`# Transported Passengers`) AS total_passenger
FROM maindata;

ALTER TABLE maindata
ADD COLUMN FullDate DATE,
ADD COLUMN Monthno INT,
ADD COLUMN Monthfullname VARCHAR(20),
ADD COLUMN Quarter VARCHAR(5),
ADD COLUMN YearMonth VARCHAR(7),
ADD COLUMN Weekdayno INT,
ADD COLUMN Weekdayname VARCHAR(20),
ADD COLUMN FinancialMonth INT,
ADD COLUMN FinancialQuarter VARCHAR(5);

ALTER TABLE maindata
MODIFY COLUMN YearMonth VARCHAR(10);


UPDATE maindata
SET
    FullDate = MAKEDATE(`Year`, 1) + INTERVAL (`Month` - 1) MONTH + INTERVAL (`Day` - 1) DAY,
    Monthno = `Month`,
    Monthfullname = MONTHNAME(MAKEDATE(`Year`, 1) + INTERVAL (`Month` - 1) MONTH),
    Quarter = CONCAT('Q', QUARTER(MAKEDATE(`Year`, 1) + INTERVAL (`Month` - 1) MONTH)),
    YearMonth = DATE_FORMAT(MAKEDATE(`Year`, 1) + INTERVAL (`Month` - 1) MONTH, '%Y-%b'),
    Weekdayno = DAYOFWEEK(MAKEDATE(`Year`, 1) + INTERVAL (`Month` - 1) MONTH + INTERVAL (`Day` - 1) DAY),
    Weekdayname = DAYNAME(MAKEDATE(`Year`, 1) + INTERVAL (`Month` - 1) MONTH + INTERVAL (`Day` - 1) DAY),
    FinancialMonth = CASE 
        WHEN `Month` >= 4 THEN `Month` 
        ELSE `Month` + 12 
    END,
    FinancialQuarter = CASE 
        WHEN `Month` BETWEEN 4 AND 6 THEN 'FQ1'
        WHEN `Month` BETWEEN 7 AND 9 THEN 'FQ2'
        WHEN `Month` BETWEEN 10 AND 12 THEN 'FQ3'
        ELSE 'FQ4'
    END;


    
SELECT 
    Year,
    SUM(`# Transported Passengers`) AS Total_Transported_Passengers,
    SUM(`# Available Seats`) AS Total_Available_Seats,
    ROUND(SUM(`# Transported Passengers`) * 100.0 / SUM(`# Available Seats`), 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Year
ORDER BY 
    Year;
    
    
    
SELECT 
    Year,
    Month,

    SUM(`# Transported Passengers`) AS Total_Transported_Passengers,
    SUM(`# Available Seats`) AS Total_Available_Seats,
    ROUND(SUM(`# Transported Passengers`) * 100.0 / SUM(`# Available Seats`), 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Year, Month
ORDER BY 
    Year, Month;
    
    
SELECT 
    Year,
    CASE 
        WHEN Month BETWEEN 1 AND 3 THEN 'Q1'
        WHEN Month BETWEEN 4 AND 6 THEN 'Q2'
        WHEN Month BETWEEN 7 AND 9 THEN 'Q3'
        WHEN Month BETWEEN 10 AND 12 THEN 'Q4'
    END AS Quarter,
    SUM(`# Transported Passengers`) AS Total_Transported_Passengers,
    SUM(`# Available Seats`) AS Total_Available_Seats,
    ROUND(SUM(`# Transported Passengers`) * 100.0 / SUM(`# Available Seats`), 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    Year,
    CASE 
        WHEN Month BETWEEN 1 AND 3 THEN 'Q1'
        WHEN Month BETWEEN 4 AND 6 THEN 'Q2'
        WHEN Month BETWEEN 7 AND 9 THEN 'Q3'
        WHEN Month BETWEEN 10 AND 12 THEN 'Q4'
    END
ORDER BY 
    Year, Quarter;

    
#Load Factor percentage on a Carrier Name basis    
SELECT 
    `Carrier Name`,
    SUM(`# Transported Passengers`) AS Total_Transported_Passengers,
    SUM(`# Available Seats`) AS Total_Available_Seats,
    ROUND(SUM(`# Transported Passengers`) * 100.0 / SUM(`# Available Seats`), 2) AS Load_Factor_Percentage
FROM 
    maindata
GROUP BY 
    `Carrier Name`
ORDER BY 
    Load_Factor_Percentage DESC;
    
#4. Identify Top 10 Carrier Names based passengers preference 
    
SELECT 
    `Carrier Name`,
    SUM(`# Transported Passengers`) AS Total_Passengers
FROM 
    maindata
GROUP BY 
    `Carrier Name`
ORDER BY 
    Total_Passengers DESC
LIMIT 10;

#top routes (From City → To City) based on the number of flights
SELECT `From - To City`, COUNT(*) AS flight_count
FROM maindata
GROUP BY `From - To City`
ORDER BY flight_count DESC
LIMIT 10;









    
    
    
    

