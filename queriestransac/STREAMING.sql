CREATE DATABASE STREAMING
GO

--USANDO LA BASE DE DATOS STREAMING
USE STREAMING
GO

--SI EXISTE LA TABLA PRODUCT SE ELIMINA PARA VOLVER A CREAR
IF EXISTS(SELECT NAME FROM sys.tables WHERE NAME='Producto')
BEGIN
    DROP TABLE Producto
END

CREATE TABLE Producto(
    [EnglishProductName] [nvarchar](50) NOT NULL,
    [Color] [nvarchar](15) NOT NULL,
    [EnglishDescription] [nvarchar](400) NULL,
    [ListPrice] [money] NULL
)
GO

select * from Producto
go
