//ver las bases de datos
show dbs

//crear o cambiar base de datos (Para que esta se cree, antes de cerrarla debe de contener una coleccion)
use db

//crear una coleccion
db.createColection()

// Para ver las colecciones de una base de datos, antes debes de estar dentro de esa base de datos
use db
show Colections

//Insertar un documento a una collection
db.empleado.insertOne({
    nombre: "Roman",
    edad:10
})

//visualizar los documentos de la coleccion. dentro de las {} van las condiciones o filtros para las consultas.
db.empleado.find({})

//Insertar varios documentos a una coleccion
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

