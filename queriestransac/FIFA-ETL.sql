use SSIS
go
select top 0 * 
into FIFACopia
from FIFA
go

select COUNT(*) from FIFA
GO
select COUNT(*) from FIFACopia
GO

select * from FIFA
GO
select * from FIFACopia
GO

create table Promedios (PiePref varchar(10), PromedioPesoKG float)
go

insert into Promedios
select PiePreferido, AVG(pesokg) from FIFA
group by PiePreferido

create table JugadoresPorNacionalidades (Nacionalidad varchar(100), CantidadJugadores int)
go

DELETE FROM Promedios
DELETE FROM JugadoresPorNacionalidades

select nacionalidad, COUNT(ID) from FIFA 
group by nacionalidad

select * from Promedios
GO
select * from JugadoresPorNacionalidades
