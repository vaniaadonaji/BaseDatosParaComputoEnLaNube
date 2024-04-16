--ORDENAR

--USAR LA BASE DE DATOS [AdventureWorksDW2016]
USE AdventureWorksDW2016
GO

--MOSTRAR LOS PRODUCTOS, CATEGORIA, SUB CATEGORIA, PRECIO UNITARIO Y LA CANTIDAD DE VENTAS
--DE LA BASE DE DATOS [AdventureWorksDW2016]
SELECT DP.EnglishProductName, DPC.EnglishProductCategoryName,
        DPS.EnglishProductSubcategoryName, FRS.UnitPrice, FRS.SalesAmount
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO