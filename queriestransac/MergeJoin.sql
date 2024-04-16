--MERGE JOIN

--USANDO LA BASE DE DATOS [AdventureWorksDW2016]
USE AdventureWorksDW2016
GO


--OBTENER INFORMACION DE EnglishProductName, EnglishProductCategoryName,
-- EnglishProductSubcategoryName, UnitPrice Y SalesAmount
SELECT DP.EnglishProductName, DPS.EnglishProductSubcategoryName,
        DPC.EnglishProductCategoryName, FRS.UnitPrice, FRS.SalesAmount
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductSubcategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

-- 1) REALIZAR LA UNION DE LAS TABLAS
-- DimProduct Y DimProductSubcategory
-- UNIDOS POR LA LLAVE ProductSubcategoryKey
SELECT ProductKey, ProductSubcategoryKey, EnglishProductName
FROM DimProduct
ORDER BY ProductSubcategoryKey
GO

SELECT ProductSubcategoryKey, ProductCategoryKey, EnglishProductSubcategoryName
FROM DimProductSubcategory
ORDER BY ProductSubcategoryKey
GO


-- 2) DEL RESULTADO OBTENIDO REALIZAR LA UNION CON LA TABLA
-- DimProductCategory
-- UNIDOS POR LA LLAVE ProductCategoryKey
SELECT ProductCategoryKey, EnglishProductCategoryName
FROM DimProductCategory
ORDER BY ProductCategoryKey
GO


-- 3) DEL RESULTADO OBTENIDO REALIZAR LA UNION CON LA TABLA
-- FactResellerSales
-- UNIDOS POR LA LLAVE ProductKey
SELECT ProductKey, UnitPrice, SalesAmount
FROM FactResellerSales
ORDER BY ProductKey
GO