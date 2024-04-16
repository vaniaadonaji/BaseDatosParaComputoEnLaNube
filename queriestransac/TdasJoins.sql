-- comando sql-ldd para crear una base de datos.
create database tdasjoins
go

use tdasjoins
go

create table categoria(
	idcategoria int not null identity(1,1),
	nombre varchar (100) not null,
	constraint pk_categoria
	primary key (idcategoria)
)
go

select * from categoria
go

use NORTHWND
go

-- crea la estructura de una tabla desde una consulta
select top 0 CategoryID, CategoryName
into categoria2
from NORTHWND.dbo.Categories
go

-- agrega un constraint a una tabla
alter table categoria2
add constraint pk_categoria2
primary key (CategoryID)
go

-- elimina un constraint
alter table categoria2
drop  pk_categoria2
go

-- elimina una columna existente
alter table categoria2
drop column  CategoryID
go

-- agrega una columna a una tabla
alter table categoria2
add CategoryID int not null identity(1,1)
go


--llenar la tabla categoria y categoria2 con una consulta.
insert into categoria2 (CategoryName)
select CategoryName from NORTHWND.dbo.Categories
go

insert into categoria (nombre)
select CategoryName from NORTHWND.dbo.Categories
go

--crear una tabla a partir de una consulta
select ProductID as numeroProducto, ProductName  as nombreProducto,
	CategoryID as categoria, UnitPrice as precioUnitario, UnitsInStock as existencia
into
	producto
from 
	NORTHWND.dbo.Products
go

select * from producto
go

-- agregar restricciones
alter table producto 
add constraint pk_producto
primary key(numeroProducto)
go

alter table producto
add constraint unico_nombreProducto
unique (nombreProducto)
go

alter table producto
add constraint chk_precioUnitario
check (precioUnitario between 1 and 100000)
go

alter table producto
add constraint chk_existencia
check (existencia >= 0 and existencia <=1000)
go

alter table producto
add constraint fk_producto_categoria
foreign key (categoria) references categoria(idcategoria)
on delete cascade
on update cascade
go

-- Inner Join
select c.idcategoria as 'Clave Categoria',
c.nombre as 'Nombre Categoria',
p.nombreProducto as 'Descripcion del Producto',
p.precioUnitario as 'Precio',
p.existencia as 'existencia',
(precioUnitario * existencia) as total
from categoria as c
join producto as p
on c.idcategoria = p.categoria
go

select *,(precioUnitario * existencia) as total from
categoria as c
inner join
(select nombreProducto,
precioUnitario,
existencia,
categoria
from producto) as p
on c.idcategoria = p.categoria
go

select *,
(precioUnitario * existencia) as total
from categoria as c
join producto as p
on c.idcategoria = p.categoria
go

select *,
(precioUnitario * existencia) as total
case
when precioUnitario = 0 then 'Precio no existente'
when precioUnitario >=1 and precioUnitario <= then 'Precio Medio'
else 'Precio Mayor'
end as 'Datos Precio'
from categoria as c
(select nombreProducto,
precioUnitario,
existencia,
categoria
from producto)
go

use NORTHWND
go

select p.ProductName, c.CategoryName
from Categories as c
join Products as p
on c.CategoryID = p.CategoryID
go

select CategoryName, ProductName from
(select CategoryID, CategoryName from Categories) as c
inner join
(select CategoryID, ProductName from Products) as p
on c.CategoryID = p.CategoryID
go

select CategoryID, count(CategoryID) as 'Numero de productos'
from Products
group by CategoryID 
go

-- seleccionar el numero de productos por categoria pero que contengan el nombre de la categoria.

select CategoryName, count(CategoryName) as 'Numero de productos'
from
(select CategoryName, CategoryID from Categories)as c
inner join
(select CategoryID, UnitsInStock
from Products) as p
on c.CategoryID = p.CategoryID
group by c.CategoryName
go


select CategoryName, count(CategoryName) as 'Numero de productos'
from
(select CategoryName, CategoryID from Categories)as c
inner join
(select CategoryID, UnitsInStock
from Products) as p
on c.CategoryID = p.CategoryID
where UnitsInStock > 100
group by c.CategoryName
go

select CategoryName, count(CategoryName) as 'Numero de productos'
from
(select CategoryName, CategoryID from Categories)as c
inner join
(select CategoryID, UnitsInStock
from Products) as p
on c.CategoryID = p.CategoryID
where UnitsInStock > 100
group by c.CategoryName
go

select * from Products
go
select * from Categories
go


---------------------------------------- ACTIVIDAD DE EVALUACIÓN--------------------------------------------

use NORTHWND
go
select * from Orders
go
select * from [Order Details]
go
select * from Products
go
select * from Categories
go
select * from Customers
go
select * from Employees
go
select * from EmployeeTerritories
go
select * from Region
go
select * from Shippers
go
select * from Suppliers
go
select * from Territories
go
-- ventas totales para cada categoría de producto, considerando solo las ventas del año 1997.
select CategoryName as 'Categoría', sum(detalleV.UnitPrice * detalleV.Quantity) as 'Venta total'
from
(select OrderID, OrderDate from Orders) as ventas
inner Join 
(select OrderID, UnitPrice, Quantity, ProductID from [Order Details]) as detalleV
on ventas.OrderID = detalleV.OrderID
inner Join
(select ProductID, CategoryID from Products) as prod
on detalleV.ProductID = prod.ProductID
inner join 
(select CategoryID, CategoryName from Categories) as cat
on prod.CategoryID = cat.CategoryID
where year(ventas.OrderDate)=1997
group by cat.CategoryName
order by 1
go

-- muestra los 5 productos más vendidos, incluyendo la cantidad total vendida de cada uno.
select TOP 5 p.ProductName as 'Productos', sum(vt.UnitPrice * vt.Quantity) 'Venta total'
from
(select * from [Order Details]) as vt
inner join 
(select * from Products) as p
on vt.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY sum(vt.Quantity) DESC
go

-- obtiene cada cliente junto con la fecha de su último pedido
select cliente.CustomerID as 'Id Cliente', cliente.ContactName as 'Cliente', max (venta.OrderDate) as 'Ultimo pedido' from
(select * from Customers) as cliente
inner join 
(select * from Orders) as venta
on cliente.CustomerID = venta.CustomerID
group by cliente.ContactName, cliente.CustomerID
order by 1
go

-- Calcula las ventas totales hechas por cada empleado por año.
select e.EmployeeID as 'Id Empleado', year(v.OrderDate) as 'Año', e.FirstName  as 'Nombre', sum(vd.Quantity * vd.UnitPrice) as 'Venta por año' from 
(select OrderID, Quantity, UnitPrice from [Order Details]) as vd
inner join 
(select OrderID, OrderDate, EmployeeID from Orders) as v
on vd.OrderID = v.OrderID
inner join
(select EmployeeID, FirstName from Employees) as e
on v.EmployeeID = e.EmployeeID
group by year(v.OrderDate), e.FirstName, e.EmployeeID
order by 1
go

-- Muestra detalles de los pedidos para productos que han sido descontinuados.
select v.OrderID, p.ProductName from
(select * from Products) as p
inner join 
(select * from [Order Details]) as vd
on p.ProductID = vd.ProductID
inner join 
(select * from Orders) as v
on vd.OrderID = v.OrderID
where p.Discontinued = 1
order by 1
go

-- Calcula los ingresos totales de los pedidos basados en el país de destino de los pedidos, para un año específico (por ejemplo, 1997).
select v.ShipCountry as 'Pais de Destino', sum(vd.UnitPrice * vd.Quantity) as 'Ingresos Totales' from
(select * from Orders) as v
inner join 
(select * from [Order Details]) as vd
on v.OrderID = vd.OrderID
where year(v.OrderDate) = 1997
group by v.ShipCountry
order by 2
go

--Muestra el precio promedio de los productos dentro de cada categoría, incluyendo solo aquellas categorías 
--cuyo precio promedio de producto supera los $20.
select CategoryID as 'Categoria', avg(UnitPrice) as 'Precio Promedio'
from Products
group by CategoryID
having avg(UnitPrice) > 20
go

--Muestra la cantidad de productos por proveedor que tienen un nivel de unidades en stock menor a 10 , 
--incluyendo solo los proveedores con más de 2 productos en esta situación.
select prov.SupplierID as 'Id Proveedor', prov.CompanyName as 'Nombre Compañia' ,COUNT(*) AS 'Cantidad de Productos' from
(select * from Suppliers) as prov
inner join 
(select * from Products) as prod
on prov.SupplierID = prod.SupplierID
where prod.UnitsInStock < 10
group by prov.SupplierID, prov.CompanyName
having count(prod.ProductID) > 2
go

--Calcula las ventas totales realizadas por cada empleado en el año 1997, 
--incluyendo solo aquellos empleados con ventas totales superiores a $50,000.
select e.EmployeeID as 'Id Empleado', e.FirstName as 'Nombre', sum(vd.UnitPrice * vd.Quantity) as 'Venta total' from
(select * from [Order Details]) as vd
inner join 
(select * from Orders) as v
on v.OrderID = vd.OrderID
inner join 
(select * from Employees) as e
on v.EmployeeID = e.EmployeeID
where YEAR(v.OrderDate) = 1997
group by e.FirstName, e.EmployeeID
having sum(vd.UnitPrice * vd.Quantity) > 50000
order by 1
go

--Lista los clientes que han realizado más de 15 pedidos en total.
select v.CustomerID as 'Id Cliente', c.CompanyName as 'Nombre',  count(v.CustomerID) as 'Pedidos'  from
(select * from Customers) as c
inner join 
(select * from Orders) as v
on c.CustomerID = v.CustomerID
group by v.CustomerID, c.CompanyName
having count(v.CustomerID) > 15
order by 3
go

-- Muestra los productos que se han vendido en una cantidad total superior a 1000 unidades.
select p.ProductID as 'Id Producto', p.ProductName as 'Nombre', sum(v.Quantity) as 'Cantidad Total' from
(select * from Products) as p
inner join 
(select * from [Order Details]) as v
on p.ProductID = v.ProductID
group by p.ProductID, p.ProductName
having sum(v.Quantity)> 1000
order by 1
go