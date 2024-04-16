--MERGE

--USAR LA BASE DE DATOS [AdventureWorksDW2016]
USE AdventureWorksDW2016
GO

--CONSULTANDO LA TABLA DimProduct
SELECT EnglishProductName,Color,EnglishDescription,ListPrice
FROM DimProduct
GO

--SELECCIONANDO LOS DATOS DONDE LA COLUMNA ListPrice
--TENGA COMO VALOR NULL
SELECT EnglishProductName,Color,EnglishDescription,ListPrice
FROM DimProduct
WHERE ListPrice IS NULL
GO

--SELECCIONANDO LOS DATOS DONDE LA COLUMNA ListPrice
--TENGA COMO VALOR DIFERENTE DE NULL
SELECT EnglishProductName,Color,EnglishDescription,ListPrice
FROM DimProduct
WHERE ListPrice IS NOT NULL
GO