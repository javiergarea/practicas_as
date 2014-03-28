Descripción
-----------

Para esta tarea debes crear un **módulo `crossring`** que exporte una función
`start/3: start(ProcNum, MsgNum, Message)`. Esta función debe crear `ProcNum`
procesos concectados un forma de anillo cruzado (piensa en la forma del
número 8) y enviar `MsgNum` veces el mensaje `Message` alrrededor del anillo
(siguiendo la silueta que se trazaría para dibujar el número 8). Una vez
enviados los mensajes, los procesos deben terminar su ejecución ordenadamente.


Notas
-----

Puedes pensar en un anillo cruzado como dos anillos que comparten un nodo.
