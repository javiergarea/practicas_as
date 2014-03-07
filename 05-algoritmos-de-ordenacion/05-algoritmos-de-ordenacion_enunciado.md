Descripción
-----------

Para esta práctica debes crear un **módulo `sorting`** que exporte dos
funciones de ordanción de listas. Ambas funciones reciben como argumento una
lista y la ordenan de la siguiente manera:

* `quicksort/1`
  Implementa el *método quicksort*. La cabeza de la lista que recibe como
  argumento sirve como pivote.

* `mergesort/1`
  Divide la lista en dos lista de longuitud similar. Se ordena recursivamente
  cada una de las listas y después se mezclan sus elementos.


Requisitos no funcionales
-------------------------

En la implementación de `mergesort` puedes emplear la función `lists:split/2`.


Notas
-----

El algoritmo [quicksort](http://en.wikipedia.org/wiki/Quicksort) aplica
los siguientes pasos:

1. Escoger un pivote y dividir la lista en dos: una con los elementos menores
   que el pivote y otra con los mayores.
2. Ordenar recursivamente las dos listas.
3. Juntar los dos listas ordenadas con el pivote en medio.

