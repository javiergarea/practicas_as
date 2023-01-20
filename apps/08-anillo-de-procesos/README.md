Descripción
-----------

Para completar esta tarea de programación debes crear un **módulo `ring`**
que exporte una función `start/3: start(ProcNum, MsgNum, Message)`. Dicha
función debe crear `ProcNum` procesos conectados en forma de anillo y enviar
`MsgNum` veces el mensaje `Message` al anillo, de forma que recorrar el anillo
completo. Una vez enviados todos los mensajes, los procesos del anillo deben
terminar su ejecución ordenadamente.

Notas
-----

Hay dos estrategias básicas para crear el anillo:

* Un *proceso distinguido* crea los demás procesos, configura el anillo y
  envía los mensajes.

* Cada proceso es reponsable de crear el siguiente proceso del anillo. En este
  caso es necesario establecer un mecanismo para que el último proceso del
  anillo se conecte al primero.
