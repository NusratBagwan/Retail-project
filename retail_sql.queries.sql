create database retail_db;
use retail_db;

CREATE TABLE retail_data (
    Order_ID VARCHAR(20),
    Order_Date DATE,
    Product_Name VARCHAR(100),
    Region VARCHAR(50),
    Sales DECIMAL(10,2),
    Profit DECIMAL(10,2),
    Inventory_Days INT,
    Quantity INT,
    Discount DECIMAL(5,2),
    Customer_ID VARCHAR(20),
    Category VARCHAR(50),
    Sub_Category VARCHAR(50)
);
-- Removed rows with NULLs in key columns
SELECT *
FROM retail_data
WHERE Product_Name IS NOT NULL
  AND Category IS NOT NULL
  AND Profit IS NOT NULL
  AND Inventory_Days IS NOT NULL;
  
  SELECT 
    Category,
    Sub_Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    ROUND(SUM(Profit) / NULLIF(SUM(Sales), 0), 2) AS Profit_Margin
FROM
    CleanedRetailData
GROUP BY Category , Sub_Category
ORDER BY Profit_Margin ASC;

SELECT 
    Category,
    AVG(Inventory_Days) AS Avg_Inventory_Days,
    SUM(Profit) AS Total_Profit
FROM
    CleanedRetailData
GROUP BY Category
ORDER BY Avg_Inventory_Days DESC;

    SELECT 
    Product_Name,
    Category,
    MONTH(Order_Date) AS Month,
    CASE 
        WHEN MONTH(Order_Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Order_Date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(Order_Date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END AS Season,
    SUM(Profit) AS Seasonal_Profit
FROM 
    CleanedRetailData
GROUP BY 
    Product_Name,
    Category,
    MONTH(Order_Date),
    CASE 
        WHEN MONTH(Order_Date) IN (12, 1, 2) THEN 'Winter'
        WHEN MONTH(Order_Date) IN (3, 4, 5) THEN 'Spring'
        WHEN MONTH(Order_Date) IN (6, 7, 8) THEN 'Summer'
        ELSE 'Fall'
    END;