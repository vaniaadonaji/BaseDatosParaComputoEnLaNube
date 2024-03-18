# MongoDB

## Vania Donaji Velazquez Torres

### Consultas con Condiciones

#### **Para las consultas con filtro tenemos la siguiente tabla con *selectores de comparacion*:**

| Nombre |                             Descripción                                     |
|--------|-----------------------------------------------------------------------------|
|  $eq   | Coincide con valores que son iguales a un valor especificado.               |
|  $gt   | Coincide con valores que son mayores que un valor especificado.             |
|  $gte  | Coincide con valores que son mayores o iguales que un valor especificado.   |
|  $in   | Coincide con cualquiera de los valores especificados en una matriz.         |
|  $lt   | Coincide con valores que son menores que un valor especificado.             |
|  $lte  | Coincide con valores que son menores o iguales que un valor especificado.   |
|  $ne   | Coincide con todos los valores que no son iguales a un valor especificado.  |
|  $nin  | No coincide con ninguno de los valores especificados en una matriz.         |

#### **Para las consultas con filtro tenemos la siguiente tabla con *selectores logicos*:**

| Nombre | Descripción                                                                                   |
|--------|-----------------------------------------------------------------------------------------------|
| $and   | Une cláusulas de consulta con una lógica AND que devuelve todos los documentos que coinciden con las condiciones de ambas cláusulas.                                   |
| $not   | Invierte el efecto de una expresión de consulta y devuelve documentos que no coinciden con la expresión de consulta.                                            |
| $nor   | Une cláusulas de consulta con una lógica NOR que devuelve todos los documentos que no coinciden con ambas cláusulas.                                           |
| $or    | Une cláusulas de consulta con una lógica OR que devuelve todos los documentos que coinciden con las condiciones de cualquiera de las cláusulas.                |

#### **Para las consultas con filtro tenemos la siguiente tabla con *selectores  de elementos*:**

| Nombre  | Descripción                                                                                         |
|---------|-----------------------------------------------------------------------------------------------------|
| $exists | Coincide con documentos que tienen el campo especificado.                                           |
| $type   | Selecciona documentos si un campo es del tipo especificado.

#### **Ejemplos de consultas con selectores lógicos, usando también selectores de comparación**
1. $and y $or  ->   $eq y $gt
```json
db.libros.fin({ $or: [ { $and: [{ editorial: { $eq: 'Biblio' } }, { precio: { $gt: 40 } }] }, { $and: [{ precio: { $gt: 30 } }, { editorial: { $eq: 'Planeta' } }] }] })
```
2. $or  ->  $eq y $lt
```json
db.libros.find({$or:[{titulo:{$eq:"MongoDB para novatos"}},{cantidad:{$lt:15}}]})
```
3. $and ->  $eq
```json
db.libros.find({$and:[{titulo:{$eq:"MongoDB para novatos"}},{editorial:{$eq:"Biblio"}}]})
```
4. $and y $or   ->  $eq y $gt
```json
db.libros.find({ $or: [ { $and: [{ editorial: { $eq: 'Biblio' } }, { precio: { $gt: 10 } }] }, { $and: [{ precio: { $gt: 30 } }, { editorial: { $eq: 'Planeta' } }] }] }, { titulo:1, cantidad:1, precio:1 ,id_:0})
```
5. $and y $or
```json
db.libros.fin({ $or: [ { $and: [{ editorial: { $eq: 'Biblio' } }, { precio: { $gt: 40 } }] }, { $and: [{ precio: { $gt: 30 } }, { editorial: { $eq: 'Planeta' } }] }] })
```

#### **Visualizar los documentos de la coleccion según las condiciones o filtros de las consultas.**
```json
db.empleado.find({$clave:{$condicion:}})
```
#### **Mostrar el primer documento encontrado en la base de datos**
```json
db.empleado.findOne({})
```

#### **Consulta con limit**
Lo que hace el *limit* es mostrar los primeros documentos que encuentra segun nuestras necesidades, en este ejemplo muestra los primeros dos documentos y solo muestra el titulo y precio. 
```json
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).limit(2)
```
#### **Consulta con sort**
Lo que hace el *sort* es ordenar los documentos.
- -1 es Descendente 
- 1 es Ascendente
En este caso los ordena por el titulo de manera ascendente.
```json
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).skip(3).sort({"titulo":1})
```

#### **Consulta con size**
Lo que hace el *size* es decirnos el número de documentos que hay según la consulta. 
```json
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).size()
```

#### **Consulta con skip**
Lo que hace el *skip* es mostrar algunos documentos, lo que hace es no mostrar los documentos que pongamos, en este ejemplo *muestra del cuarto documento en adelante*, no muestra los primeros 3. 
```json
db.libros.find({}, { "titulo": 1, "precio": 1, "_id": 0, "editorial": 1 }).skip(3)
```

#### **Consulta con exists**
Lo que hace el *exists* es mostrar todos los documentos que contengan el campo. 
```json
db.libros.find({titulo:{$exists:true}})
```
