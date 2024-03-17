# Agregaciones en MongoDB
### Agregación con 3 Stages
1. $match
2. $project
3. $sort
```json
[
    {
      $match:
        {
          editorial: "Biblio"
        }
    },
    {
      $project:
        {
          _id: 0,
          titulo: 1,
          precio: 1,
          cantidad: 1,
          "Nombre Editorial": "$editorial",
          "Total Ganancia": {
            $multiply: ["$precio", "$cantidad"]
          }
        }
    },
    {
      $sort:
        {
          precio: 1
        }
    }
]
```

### Agregación con 2 Stages
1. $group
2. $sort
```json
[
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          "Numero Documentos": {
            $count: {},
          },
        },
    },
    {
      $sort:
        /**
         * Provide any number of field/order pairs.
         */
        {
          "Numero Documentos": -1,
        },
    },
  ]
```

### Agregación con 1 Stage
1. $group
```json
  [
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          "Numero de Documentos": {
            $count: {},
          },
          media: {
            $avg: "$precio",
          },
        },
    },
  ]
```

### Agregación con 3 Stages
1. $group
2. $set
3. $out
```json
  [
    {
      $group:
        /**
         * _id: The id of the group.
         * fieldN: The first field name.
         */
        {
          _id: "$editorial",
          "Numero de Documentos": {
            $count: {},
          },
          media: {
            $avg: "$precio",
          },
        },
    },
    {
      $set:
        /**
         * field: The field name
         * expression: The expression.
         */
        {
          "Media Total": {
            $trunc: ["$media", 2],
          },
        },
    },
    {
      $out:
        /**
         * Provide the name of the output collection.
         */
        "Media_Editoriales",
    },
  ]
```

### Agregación con 3 Stages
1. $group
2. $set
3. $unset
```json
  [
    {
      $group:
        /**
        * _id: The id of the group.
        * fieldN: The first field name.
        */
        {
          _id: "$editorial",
          "Numero de Documentos": {
            $count: {},
          },
          media: {
            $avg: "$precio",
          },
        },
    },
    {
      $set:
        /**
        * field: The field name
        * expression: The expression.
        */
        {
          "Media Total": {
            $trunc: ["$media", 2],
          },
        },
    },
    {
      $unset:
        /**
        * Provide the name of the output collection.
        */
        "media",
    },
  ]
  ```