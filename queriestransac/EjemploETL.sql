create database ejemploetl
go

use ejemploetl
go

select * from
NORTHWND.dbo.Categories
go

-- Permite visualizar las caracteristicas de las tablas
select * from sys.tables


create table productos (
	productoId int not null identity(1,1),
	nombreproducto nvarchar(40) not null,
	precio money not null,
	stock smallint not null,
	--	Campo calculado
	importe as
	(precio * stock),
	categoria nvarchar (15) not null,
	constraint pk_producto 
	primary key (productoId)
)
go

alter table productos 
add categoria nvarchar(15) not null
go

select * from productos
go

select * from
NORTHWND.dbo.Categories
go

insert into ejemploetl.dbo.productos
select p.ProductName, p.UnitPrice, p.UnitsInStock, c.CategoryName from
NORTHWND.dbo.Products as p
inner join NORTHWND.dbo.Categories as c
on c.CategoryID = p.CategoryID
go