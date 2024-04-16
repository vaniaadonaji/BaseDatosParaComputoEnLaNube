use  Northwind
GO

select * from Categories
GO

select * from CustomerCustomerDemo
GO

select * from CustomerDemographics
GO

select * from Customers 
GO

select * from Employees
GO

select * from EmployeeTerritories
GO

select * from [Order Details]
GO

select * from Orders 
GO 

select * from Products
GO

select * from Region
GO

select * from Shippers
GO

select * from Suppliers
GO

select * from Territories
GO

execute sp_helpindex 'Categories'
GO

execute sp_helpindex 'CustomerCustomerDemo'
GO

execute sp_helpindex 'CustomerDemographics'
GO

execute sp_helpindex 'Customers'
GO

execute sp_helpindex 'Employees'
GO

execute sp_helpindex 'EmployeeTerritories'
GO

execute sp_helpindex '[Order Details]'
GO

execute sp_helpindex 'Orders'
GO

execute sp_helpindex 'Products'
GO

execute sp_helpindex 'Region'
GO

execute sp_helpindex 'Shippers'
GO

execute sp_helpindex 'Territories'
GO

create or alter view ejemplo as
	select 
			CategoryName, CategoryID, picture
	from
			Categories
	where
			CategoryName = 'Beverages';

-- drop view ejemplo;

select * from ejemplo;

create nonclustered index IDX_faxclu on Customers(fax)
go

create nonclustered index IDX_countryclu on Customers(country)
go

select 
	ProductID, ProductName,CategoryID
from
	Products
where
	CategoryID in
	(select CategoryID from Categories where CategoryName='Beverages')
GO

select 
	EmployeeID, LastName, FirstName, Title, Address
from
	Employees
where
	Title in ('Vice President, Sales', 'Sales Manager')
GO

select 
	EmployeeID, LastName, FirstName, Title, Address
from
	Employees
where
	Title = 'Vice President, Sales' and Title = 'Sales Manager'
GO

select 
	 ProductName, UnitPrice
from
	Products
where
	SupplierID in
	(select SupplierID from Suppliers where Country='USA')
GO

select 
	 ProductName, UnitPrice
from
	Products
where
	CustomerID in
	(select CustomerID from Customers where CustomerID='ALFKI' in (select ))
GO

select ProductName, UnitPrice
from Products
where ProductID in (
			select ProductID
			from [Order Details]
			where OrderID in (
					select OrderID 
					from Orders
					where CustomerID ='ALFKI'
					)
			)
GO

select *
from Products;

select *
from [Order Details]
where OrderID=3;

select OrderID 
from Orders
where CustomerID ='ALFKI';

select * from Customers;
GO

-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Filtrar por OrderID:
select * from [Order Details] where OrderID = 10248;

-- Filtrar por ProductID:
select * from [Order Details] where ProductID = 7;

-- Filtrar por Quantity:
select * from [Order Details] where Quantity > 10;

-- Filtrar por Precio Unitario (UnitPrice):
select * from [Order Details] where UnitPrice between 5.00 and 10.0;

-- Filtrar por descuento (Discount):
select * from [Order Details] where Discount > 0.05;

-- Filtrar por OrderID y ProductID:
select * from [Order Details] where OrderID = 10248 and ProductID = 7;

-- mostrar una lista de todos los empleados EmplyeeID, FirstName, Title, BirthDate, ReportsT que tiene un valor en ReportsT entre 3 y 8.
select EmployeeID, FirstName, Title, BirthDate, ReportsTo from Employees where ReportsTo between 3 and 8;

select EmployeeID, LastName, FirstName, Title, BirthDate, ReportsTo from Employees where BirthDate between '01-01-1920' and '12-12-1960';

select * from Products where CategoryID=1;
select * from Products where SupplierID=5;
select * from Products where ProductName like '%chai%';
select * from Products where UnitPrice >20.00;
select * from Products where Discontinued=1;
select * from Products where CategoryID=1 and SupplierID=5;


select * From Products where CategoryID=1 or CategoryID=2;
select * From Products where not SupplierID=3;
select * From Products where ProductName like '%chai%' or UnitPrice >20.00;
select * From Products where not Discontinued=1 and UnitPrice <=10;

-- 01/06/2023 ------------------------------------------------------------------------------------------------------------------------------------------------------------------
select * from Products where ProductName='Chai' and SupplierID=1;

select * from Products where ProductName='Chai' or ProductName='Chang' or ProductName='Tofu';

select * from Products where UnitPrice>100;

select * from Products where UnitPrice>100 and UnitPrice<300;

select * from Products where UnitPrice between 100 and 300;

select * from Products where UnitPrice between 114 and 175 order by UnitPrice asc;

select UnitPrice from Products order by UnitPrice asc;

select ProductID from Products where UnitPrice=4.50;

select * from Products where UnitPrice>2.50 and UnitPrice<9;

select * from Products where UnitPrice between 2.50 and 7.75;

select UnitPrice max from Products;

select ProductName from Products;
-- LIKE: compara puro texto

select * from Products where ProductName LIKE 'Q%'

select * from Products where ProductName LIKE '%O'

select * from Products where ProductName LIKE '%B%'

select * from Products where ProductName LIKE '____'

select * from Products order by ProductName;
select * from Products order by ProductName desc;

select SupplierID, COUNT(SupplierID)as 'cantidad' from Products group by SupplierID;

select * from [Order Details];
select 
	OrderID, count (OrderID) as 'cantidad' 
from 
	[Order Details] group by OrderID 
having 
	count (OrderID)>2 order by 'cantidad';

select ProductID, ProductName, CategoryID, 
(select CategoryName from Categories 
where CategoryID = Products.CategoryID) as 'categoria' ,
(select CompanyName from Suppliers
where SupplierID = Products.SupplierID) as 'proveedor',
(select SUM(UnitPrice) from [order details] 
where ProductID = Products.ProductID) 'precio'
from Products order by ProductID;

-- 02/06/2023 ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
select 
	Products.ProductID, Products.ProductName, Products.CategoryID, Categories.CategoryName as categoria, 
	Suppliers.CompanyName as proveedor, SUM([Order Details].UnitPrice) as precio 
from
	Products join Categories on Products.CategoryID = Categories.CategoryID
			 join Suppliers on Products.SupplierID = Suppliers.SupplierID
			 join [Order Details] on Products.ProductID = [Order Details].ProductID
group by Products.ProductID, Products.ProductName, Products.CategoryID, Categories.CategoryName, Suppliers.CompanyName
order by ProductID


select 
	convert (nvarchar (2), EmployeeID)+' '+LastName+' '+FirstName as Nombre
from 
	Employees

-- --------------------------------------------------------------------------------------------------------------------------
select EmployeeID,ShipCountry, OrderID, 
(select FirstName from Employees 
where EmployeeID = Orders.EmployeeID) as 'employees' ,
(select City from Customers 
where CustomerID = Orders.CustomerID) as 'City´s Customers'
from Orders order by OrderID;


select 
	UnitPrice
from
	Products
where
	UnitPrice in (10.0,18.0,19.0)


select LastName from Employees where LastName LIKE '[A-M]%' ;

select * from Suppliers where region is null;

select UnitPrice from Products order by UnitPrice desc; -- 263.50

select ProductID, ProductName, UnitPrice
from Products
where UnitPrice= 263.50

select 
	ProductID, UnitPrice,ProductName
from 
	Products 
where 
	UnitPrice=(select max(UnitPrice) from Products);


select ProductID as ID,ProductName as Nombre, UnitPrice as Precio_Unitario
from Products 
where UnitPrice=(select min(UnitPrice) from Products)
union
select ProductID as ID, ProductName as Nombre, UnitPrice as Precio_Unitario
from Products where UnitPrice=(select min(UnitPrice)from Products)
GO

select ProductID as ID,ProductName as Nombre, UnitPrice as Precio_Unitario
from Products 
where UnitPrice=(select min(UnitPrice) from Products)
union all
select ProductID as ID, ProductName as Nombre, UnitPrice as Precio_Unitario
from Products where UnitPrice=(select min(UnitPrice)from Products)
GO

select
RP.*
from 
		(select
		C.CategoryName as catnom, P.UnitPrice as precio, P.ProductName as nompro
	from
		Products as P inner join Categories as C on P.CategoryID=C.CategoryID) AS RP
	inner join
	(select
		C.CategoryName as cmp, MAX(P.UnitPrice) as pmp
	 from
		Products as P inner join Categories as C on P.CategoryID=C.CategoryID group by C.CategoryName) as MP
		on RP.catnom=MP.cmp and RP.precio=MP.pmp

-- si se ejecuta el group by, se necesita una función de agregado.

select 
	C.CategoryName, P.ProductName,P.UnitPrice
from 
	Products as P inner join Categories as C on P.CategoryID=C.CategoryID
where 
	UnitPrice=(select max(UnitPrice) from Products);

-- -------------------------------------------------------------PRACTICAS------------------------------------------------------------------------------------------------------------------
-- Crear una subconsulta para obtener los IDs de los proveedores en Estados Unidos, y luego se seleccionan los productos cuyos proveedores tienen esos IDs.
select
	ProductName, UnitPrice, SupplierID
from
	Products
where SupplierID in
	(select SupplierID
	From
		Suppliers
	Where Country='USA')
GO

-- Crear una subconsulta para obtener los productos y sus precios de la tabla "Products" que están asociados a los pedidos realizados por un cliente específico con el ID 
--'ALFKI'. La subconsulta interna más anidada obtiene los IDs de los pedidos del cliente 'ALFKI' en la tabla "Orders". La subconsulta intermedia
--obtiene los IDs de los productos en la tabla "OrderDetails" que están relacionados con los IDs de los pedidos obtenidos en la subconsulta interna. Finalmente, la consulta
-- externa recupera los nombres de los productos y sus precios de la tabla "Products" utilizando los IDs de productos obtenidos en la subconsulta intermedia.
select
	ProductName, UnitPrice
from
	Products
where ProductID in
	(select
		ProductID
	from
		[Order Details]
	where OrderID in
		(select 
			OrderID
		from 
			Orders
		where CustomerID='ALKI'));

--Crear una subconsulta para obtener los nombres de los productos y los nombres de los proveedores de la tabla "Products" que están asociados a los proveedores ubicados en los
--Estados Unidos. La subconsulta interna obtiene los IDs de los proveedores en la tabla "Suppliers" que tienen el país igual a 'USA'. La consulta externa
--recupera los nombres de los productos y los nombres de los proveedores de la tabla "Products" utilizando los IDs de los proveedores obtenidos en la subconsulta interna.
select 
	ProductName, SupplierID
from
	Products
where SupplierID in
	(select 
		SupplierID
	from
		Suppliers
	where Country='USA')