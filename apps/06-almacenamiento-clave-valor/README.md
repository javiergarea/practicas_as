Descripción
-----------

Para esta práctica debes crear un **módulo `db`** que funcione como un
alamacenamiento *clave-valor* basado en listas. La interface pública del
módulo es:

* `db:new() -> DbRef`
  Crea el almacen de datos.

* `db:write(Key, Element, DbRef) -> NewDbRef`
  Inserta un nuevo elemento en el almacen `DbRef`.

* `db:delete(Key, DbRef) -> NewDbRef`
  Elimina la primera ocurrencia de la clave `Key` en el almacen `DbRef`.

* `db:read(Key, DbRef) -> {ok, Element} | {error, instance}`
  Recupera la primera ocurrencia de la clave `Key` en el almacen `DbRef`,
  o devuelve un valor de error sin no existe. 

* `db:match(Element, DbRef) -> [Key, ..., KeyN]`
  Recupera todas las claves que contengan el valor `Element`.

* `db:destroy(DbRef) -> ok`
  Elimina el almacenamiento `DbRef`.


Requisitos no funcionales
-------------------------

En la implementación de este módulo no puedes usar la librería `lists`.


Notas
-----

No es necesario emplear un tipo de dato opaco para implementar las referencias
a almacen de datos, `DbRef`, puedes usar la propia lista.
