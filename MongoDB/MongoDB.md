# MongoDB

## Vania Donaji Velazquez Torres

### Términos de Mongo DB vs SQL:
|         SQL        |          Mongo DB         | 
|--------------------|---------------------------|
| Base de datos      | Base de datos             | 
| Tabla o relaciones | Colecciones               | 
| index              | index                     | 
| Fila               | Documentos                | 
| Columna            | Campo                     | 
| Joins              | Integrados en el documento| 

JSON: Java Script Object Notation.  
Los datos se separan por clave valor aunque no son de tipo clave valor, son documentales.

### Estructura de un JSON:
```JSON
{
  "clave1": "valor1",
  "clave2": "valor2",
  "clave3": {
    "clave3-1": "valor3-1",
    "clave3-2": "valor3-2"
  },
  "clave4": ["valor4-1", "valor4-2", "valor4-3"]
}
```
### Tipos de datos en MongoDB
- Double
- String
- Object
- Array
- Binary Data
- Undifined -> Deprecated
- ObjectID
- Boolean
- Regular Expresion
- JavaScript
- Int
- Long
- Timestmp
- Biginter

## Comandos Básicos de MongoDB

#### **Ver las bases de datos**
- show dbs

#### **Crear o cambiar base de datos (Para que esta se cree, antes de cerrarla debe de contener una coleccion)**
- use db

#### **Para ver las colecciones de una base de datos, antes debes de estar dentro de esa base de datos**
- use db
- show Colections

#### **Crear una coleccion**
```json
db.createColection('nombre_de_la_coleccion')
```

#### **Insertar un solo documento a una collection**
```json
db.empleado.insertOne({
    nombre: "Roman",
    edad:10
})
```

#### **Visualizar todos los documentos de la coleccion.**
```json
db.empleado.find({'condicion'})
```
#### **Insertar varios documentos a una coleccion**
```json
 db.empleado.insertMany(
     [
     {
     nombre:"Hermerejilgo",
     edad:67,
     },
     {
     nombre:"Soy la vaca del corral",
     edad:14,
     sexo:"Mujer"
    },
    {
    nombre:"Romulo",
    edad:40,
    nacionalidad:"Nigeriano"
    },
    {
    nombre:"Cristian Andres",
    localidad:"San Miguel de las Piedras",
    nacionalidad:"Aleman",
    edad:"esta morro"
    }
    ]
    )
```

#### **Eliminar una base de datos**
```json
db.dropDataBase('')
```

#### **Limpiar la pantalla de mongo shell:**
- cls

#### **Eliminar varios documentos**
```json
db.libros.deleteMany( { cantidad: { $gt: 20 } })
```

#### **Eliminar un solo documento**
```json
db.libros.deleteOne({"_id":13})
```

#### **Reemplaza un documento**
```json
db.libros.replaceOne( { "_id": 13 }, { "_id": 13, "titulo": "Las patoaventuras de Ezequiel alias Mateo" })
```

#### **Actualizar varios documentos**
```json
db.libros.updateMany( { cantidad: { $gt: 20 } }, { $mul: { precio: 2 } })
```

#### **Actualizar un solo documento**
```json
db.libros.updateOne( {_id:13},{$set:{precio:277}},{$set:{cantidad:50}})
```