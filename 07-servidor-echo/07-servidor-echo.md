Descripción
-----------

La tarea para esta práctica consiste en crear un **módulo `echo`** en el que
implementes un proceso servidor que, después de arrancar, permanezca esperando
a recibir mensajes. Dependiendo del mensaje recibido deberá imprimir el mensaje
y volver a quedar a la espera, o detener su ejecución.

La implementación del módulo debe ocultar a los clientes la creación del
proceso y el paso de mensajes, por lo que el acceso a las funcionalidades del
proceso servidor se hará a través de una interface compuesta por las siguientes
funciones públicas que se incluirán en el propio módulo `echo`:

* `echo:start() -> ok`
  Crea (`spawn`) y registra (`register`) el proceso servidor.

* `echo:stop() -> ok`
  Envía el mensaje de parada al servidor.

* `echo:print(Term) -> ok`
  Envía el mensaje de imprimir al servidor.
