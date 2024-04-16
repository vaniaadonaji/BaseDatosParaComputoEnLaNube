--FUNCION DE AGREGACION

--USAR LA BASE DE DATOS [AdventureWorksDW2016]
USE AdventureWorksDW2016
GO

--CONSULTA A LA TABLA DimProduct, DimProductSubcategory, DimProductCategory
SELECT * FROM DimProduct
GO

SELECT * FROM DimProductSubcategory
GO

SELECT * FROM DimProductCategory
GO

SELECT * FROM FactResellerSales
GO

--MOSTRAR LOS PRODUCTOS, CATEGORIA, SUB CATEGORIA, PRECIO UNITARIO Y LA CAN
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

--SELECCIONAR EL PRECIO UNITARIO MAXIMO DE LA TABLA FactResellerSales
SELECT MAX(FRS.UnitPrice) AS PrecioMaximo
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--SELECCIONAR EL PRECIO UNITARIO MINIMO DE LA TABLA FactResellerSales
SELECT MIN(FRS.UnitPrice) AS PrecioMinimo
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--REALIZAR LA SUMA DEL PRECIO UNITARIO DE LA TABLA FactResellerSales
SELECT SUM(FRS.UnitPrice) AS PrecioSuma
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--UnitPrice
--195399481.5487

--REALIZAR EL PROMEDIO DEL PRECIO UNITARIO DE LA TABLA FactResellerSales
SELECT AVG(FRS.UnitPrice) AS PrecioPromedio
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--UnitPrice
--761.9785


--CONTAR LA CANTIDAD TOTAL DE LOS PRODUCTOS
SELECT COUNT(DP.EnglishProductName) AS CantidadProductos
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--CONTAR LOS DISTINTOS VALORES QUE EXISTE EN LA COLUMNA EnglishProductName
SELECT COUNT( DISTINCT DP.EnglishProductName) AS CantidadRegistro
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--COMPROBACION
SELECT DISTINCT DP.EnglishProductName AS CantidadRegistro
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GO

--REALIZAR LA SUMA DEL PRECIO UNITARIO POR NOMBRE DEL PRODUCTO
SELECT DP.EnglishProductName, SUM(UnitPrice) PrecioTotal
FROM DimProduct DP INNER JOIN DimProductSubcategory DPS
ON DP.ProductSubcategoryKey = DPS.ProductCategoryKey
                    INNER JOIN DimProductCategory DPC
ON DPC.ProductCategoryKey=DPS.ProductCategoryKey
                    INNER JOIN FactResellerSales FRS
ON FRS.ProductKey=DP.ProductKey
GROUP BY DP.EnglishProductName
GO