Descripción
-----------

Para realizar esta práctica, debes crear un **módulo `manipulating`** que
exporte las siguientes funciones:

* `filter/2`
  Dadas una lista de enteros `L` y un entero `N`, devuelve una lista que
  contiene los elementos de `L` que son más pequeños o iguales que `N`.
  Por ejemplo: `filter([1,2,3,4,5],3) -> [1,2,3]`.

* `reverse/1`
  Dada una lista en enteros, devuelve una lista que contiene los mismos
  elementos pero en orden inversa. Por ejemplo: `reverse([1,2,3]) -> [3,2,1]`.

* `concatenate/1`
  Dada una lista de listas `L`, devuelve una lista que es el resultado de
  concaternar los elementos de `L`.
  Por ejemplo: `concatenate([[1,2,3], [], [4,five]]) -> [1,2,3,4,five]`.

* `flatten/1`
  Dada una lista de listas anidadas `L` (lista de listas de listas de ...),
  devuelve un lista que es el resultado de aplanar `L`. Por ejemplo:
  `flatten([[1,[2,[3],[]]], [[[4]]], [5,6]]) -> [1,2,3,4,5,6]`.


Requisitos no funcionales
-------------------------

El objeto de la tarea es la manipulación de listas, por tanto no puedes usar 
las funciones del módulo `lists`.

Recuerda que el operador `++` es en realidad un sinónimo de `lists:append` y
por tanto consideraremos que está incluido en el módulo `lists`.
