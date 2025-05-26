SELECT * FROM grocery_data

UPDATE grocery_data
SET Item_Fat_Content =
	CASE 
		WHEN Item_Fat_Content IN ('LF', 'low fat') THEN 'Low Fat'
		WHEN Item_Fat_Content IN ('reg') THEN 'Regular'
		ELSE Item_Fat_Content
	END;

SELECT DISTINCT Item_Fat_Content FROM grocery_data

UPDATE grocery_data
	SET Sales = Sales/10000;

UPDATE grocery_data
	SET Item_Weight = Item_Weight/10;

UPDATE grocery_data
	SET Item_Visibility = Item_Visibility/1000000000;

UPDATE grocery_data
	SET Rating =
		CASE 
			WHEN Rating<10 THEN CAST(RATING AS DECIMAL(3,1))
			ELSE CAST(RATING/10 AS DECIMAL(3,1))
		END;

SELECT CAST(SUM(Sales)/1000000 AS DECIMAL(10,2)) AS Total_Sales_Millions
	FROM grocery_data

SELECT CAST(AVG(Sales) AS DECIMAL(5,2)) AS Avg_Sales
	FROM grocery_data

SELECT COUNT(*) 
	FROM grocery_data AS No_Of_Items

SELECT CAST(AVG(Rating) AS DECIMAL(3,2)) AS Avg_Rating 
	FROM grocery_data

SELECT * FROM grocery_data

SELECT Item_Fat_Content, 
		CAST(SUM(Sales)/1000 AS DECIMAL(10,2)) AS Total_Sales_Thousand,
		CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avarage_Sales,
		COUNT(*) AS Number_Of_Items,
		CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avarage_Rating
FROM grocery_data
GROUP BY Item_Fat_Content
ORDER BY Total_Sales_Thousand DESC 


SELECT Item_Type, 
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avarage_Sales,
	COUNT(*) AS Number_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avarage_Rating
FROM grocery_data
GROUP BY Item_Type
ORDER BY Total_Sales DESC

SELECT Outlet_Location_Type,
	ISNULL([Low Fat],0) AS Low_Fat,
	ISNULL([Regular],0) AS Regular
FROM(
	SELECT Outlet_Location_Type, Item_Fat_Content,
		CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales
	FROM grocery_data
	GROUP BY Outlet_Location_Type, Item_Fat_Content
) AS Source_Table
PIVOT(
	SUM(Total_Sales)
	FOR Item_Fat_Content IN ([Low Fat],[Regular])
) AS Pivot_Table
ORDER BY Outlet_Location_Type

SELECT Outlet_Establishment_Year,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Avarage_Sales,
	COUNT(*) AS Number_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avarage_Rating
FROM grocery_data
GROUP BY Outlet_Establishment_Year
ORDER BY Outlet_Establishment_Year DESC

SELECT 
	Outlet_Size,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST((SUM(Sales)*100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage
FROM grocery_data
GROUP BY Outlet_Size
ORDER BY Total_Sales DESC

SELECT
	Outlet_Location_Type,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST((SUM(Sales)*100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Average_Sales,
	COUNT(*) AS Number_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avarage_Rating
FROM grocery_data
GROUP BY Outlet_Location_Type

SELECT
	Outlet_Type,
	CAST(SUM(Sales) AS DECIMAL(10,2)) AS Total_Sales,
	CAST((SUM(Sales)*100.0 / SUM(SUM(Sales)) OVER()) AS DECIMAL(10,2)) AS Sales_Percentage,
	CAST(AVG(Sales) AS DECIMAL(10,2)) AS Average_Sales,
	COUNT(*) AS Number_Of_Items,
	CAST(AVG(Rating) AS DECIMAL(10,2)) AS Avarage_Rating
FROM grocery_data
GROUP BY Outlet_Type
ORDER BY Total_Sales DESC