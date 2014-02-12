Descripción
-----------

Debes **crear un módulo llamado `boolean`** que exporte al menos tres funciones: `b_not/1`, `b_and/2` y `b_or/2`. Estas funciones deben recibir un valor booleano (representados por los *átomos* `true` y `false`) y evaluar su valor de verdad. Por ejemplo, `b_not(true)` debe devolver `false`.

En la implementación de las funciones de este módulo **no puedes usar los operadores `and`, `or`, `not` ni `andalso` o `orelse`** definidos por el lenguaje.


Requisitos no funcionales
-------------------------

Las funciones se pueden implementar empleando únicamente el pattern matching en las clausulas de las funciones sin recurrir al uso de guardas o estructuras case o if.

