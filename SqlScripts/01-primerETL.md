# Primer ETL

## Pasos para generar la parte inicial

1. Ejecutar el script de creación

2. Generar una consulta para crear una tabla a partir de un select
```sql
select top 0 * 
into FIFACopia
from FIFA
```

3. Crear un proyecto en SSIS y crear un paquete que se llame 01-primerETL.md

4. Crear una coneción a la base de datos SSIS con el conector **Microsoft OLE DB Driver for SQLServer**

5. Agregar en el controlflow un componente **Execute SQL Task** NOTA: Permite ejecutar comandos SQL

6. Agregar al ETL un componente **Tarea de Flujo de datos/ Data Flow Task** y se enlaza con el **Tarea Ejecutar SQL/ Execute SQL Task**