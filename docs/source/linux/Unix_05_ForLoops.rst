

.. _Unix_05_ForLoops:

===========================
Tutorial de Unix n.º 5: Bucles for
===========================

.. nota::

  Temas tratados: variables, bucles for, relleno de ceros, punto y coma
  
  Comandos cubiertos: for, seq



Descripción general
--------

El análisis de neuroimagen suele implicar la ejecución de muchos comandos, pero con solo una pequeña modificación cada vez que se ejecuta un nuevo comando. Por ejemplo, podría tener que analizar al sujeto 1, luego al sujeto 2, al sujeto 3, y así sucesivamente. Para ahorrar tiempo, usaremos un bucle, también conocido como bucle for.

Ilustremos esto con un ejemplo sencillo. Supongamos que necesita imprimir los números 1, 2 y 3. Podría hacerlo escribiendo "echo 1" y pulsando Intro; luego, echo 2 y echo 3. Esto funciona, pero puede ver que se volvería tedioso rápidamente si su objetivo fuera imprimir docenas o cientos de números.

¿Cómo podemos simplificar esto? Probablemente hayas notado que cada vez que ejecutamos el comando, cambiamos el número después del comando echo. Un bucle for lo hará automáticamente.

A continuación se muestra un ejemplo de un bucle for para imprimir los números 1, 2 y 3:
::

  para i en 1 2 3
  hacer eco $i
  hecho

O bien, hacerlo en una sola línea, con cada sección separada por punto y coma:

::

  para i en 1 2 3; hacer eco $i; hecho

El bucle for tiene tres secciones, separadas por punto y coma. La primera sección es la Declaración: comienza asignando el primer elemento después de "in" a la variable "i"; en este caso, le asignaría el valor "1". Los números después de "in" se llaman "Lista". La siguiente sección es el Cuerpo, que ejecuta los comandos escritos después de "do", reemplazando la variable con el valor que tenga asignado actualmente; para el primer bucle, este será el número "1". Dado que los elementos permanecen en la lista, el bucle regresa a la declaración y asigna el siguiente número de la lista a la variable i; en este caso, el número "2". Luego se ejecuta el cuerpo y el proceso se repite hasta que se llega al final de la lista. La última sección, llamada Fin, contiene solo la palabra "done", que significa salir del bucle después de que todos los elementos de la lista se hayan ejecutado a través del Cuerpo del bucle.

Puedes agregar más comandos a la sección "Cuerpo", separándolos con punto y coma. Por ejemplo, podríamos cambiar el bucle a:

::

  para i en 1 2 3; hacer echo $i; echo “Acabas de imprimir el número $i”; hecho
  
Y así es como se vería el resultado:

::

  1
  Acabas de imprimir el número 1
  2
  Acabas de imprimir el número 2
  3
  Acabas de imprimir el número 3

De cara al futuro, usaremos bucles for para analizar veintiséis sujetos, con directorios llamados sub-01, sub-02 y hasta sub-26. Usaremos el bucle para navegar por cada directorio y luego ejecutar un script, pero por ahora, imaginemos que simplemente queremos imprimir el nombre de cada directorio. Algo como esto funcionaría, pero también sería tedioso de escribir:

::

  para i en sub-01 sub-02 … sub-26; hacer eco $i; hecho

Esto también se vuelve rápidamente impráctico con números grandes. Puede simplificar este comando usando el comando seq, que imprime todos los números en un rango especificado; por ejemplo, seq 1 10 imprime los números del uno al diez. Podemos incluirlo en nuestro bucle for usando comillas invertidas, donde el comando dentro de las comillas invertidas se ejecuta primero y se expande:

::

  para i en `seq 1 26`; hacer eco “sub-$i”; hecho

En este caso, la primera ejecución del bucle asignaría 1 a i, imprimiría sub-1 y luego recorrería el resto de los elementos de la lista.

Esto nos acerca a nuestro objetivo, pero aún no es exactamente lo que buscamos. Observe que cada nombre de sujeto tiene dos enteros, como 01, 02, 03, etc., lo que garantiza que el nombre de cada sujeto tenga la misma longitud; además, los mantiene en orden al listarlos con el comando ls. Esto se llama relleno de ceros y podemos implementarlo en nuestro bucle for con la opción -w en seq, que se ve así:

::

  para i en `seq -w 1 26`; hacer eco “sub-$i”; hecho

Esto establece que cada número en este rango tenga una anchura de dos enteros; si es un número menor que diez, por ejemplo, se rellena con un cero a la izquierda. Esto será importante más adelante, cuando usemos estos bucles para automatizar los análisis de todos nuestros sujetos.

-------

Ceremonias
*********

Hoy cubrimos los fundamentos de los bucles for; más adelante, aprenderá a usarlos en contextos más sofisticados, como automatizar el análisis de un conjunto de datos completo. Pero, independientemente de la complejidad del análisis, cada bucle for se basa en los fundamentos que aprendió hoy. Pruebe estos ejercicios para mejorar su comprensión:

1. Escribe la siguiente línea de código: ``for i in `ls`; do echo $i; done``. Antes de pulsar Intro, piensa en el resultado que devolverá. Comprueba si el resultado coincide con tu predicción.

2. Escriba un bucle for para realizar lo siguiente para los números del 1 al 3: imprimir el primer número de la lista y, a continuación, el directorio de trabajo actual. Después, suba un directorio. Repita el proceso para todos los demás números de la lista.

3. Busque la sintaxis de un bucle for con tcsh y utilícela para rehacer los ejemplos anteriores.


--------

Video
*****

Haga clic aquí`__ para un ejemplo de cómo codificar bucles for.

   

