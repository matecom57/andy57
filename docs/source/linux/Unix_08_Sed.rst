

.. _Unix_08_Sed:

Tutorial de Unix n.° 8: El comando Sed
================

.. nota::

  Temas tratados: Edición de transmisiones, intercambio
  
  Comandos cubiertos: sed
  

Descripción general
*********

Los comandos que has aprendido hasta ahora te permitirán crear scripts flexibles que se adaptan a diversos escenarios. Hay un comando más que aprenderás para completar tu conjunto de herramientas de comandos Unix: el comando ``sed``.

Sed es una abreviatura de "editor de flujo", en el sentido de que la entrada a sed es un flujo de texto: el mismo concepto que los flujos de entrada y salida que se analizaron en un capítulo anterior.Nuestro objetivo es tomar un flujo de texto de entrada y reemplazar una cadena por otra. La ventaja de Sed sobre un procedimiento similar con bucles for es que puede editar un archivo y solo cambiar ciertas palabras, sobrescribiéndolo y dejando el resto del texto intacto.

Ejemplo con Sed
*********

Para ver cómo funciona sed, cree un archivo de texto llamado ``Hello.sh`` que contenga la siguiente línea:

::

  #!/bin/bash
  
  echo "Hola, mi nombre es Andy. Aquí está el nombre Andy nuevamente."
  

Este es simplemente un archivo de texto que ejecuta una línea de código. Si quisieras cambiar el nombre Andy por Bill, escribirías lo siguiente:

::

  sed "s|Andy|Bill|g" Hola.sh
  
Tenga en cuenta que el comando sed está dividido en tres secciones:

1. Declarar el comando sed;
2. Un patrón para combinar y reemplazar con otro patrón, entre comillas;
3. El archivo que se leerá en sed (en este caso, Hello.sh)

Centrémonos en la sección del patrón. Prefiero encerrar esta sección entre comillas dobles para que, si incluyo una variable en el patrón, se expanda antes de ejecutar el comando sed. La primera parte de esta sección es una "s", que significa "intercambiar" el siguiente par de cadenas. La primera del par es lo que se busca en el archivo de texto y la segunda es lo que se reemplazará. La "g" significa "global", lo que significa reemplazar cada instancia de la primera palabra con la segunda.

Si ejecuta este comando, debería ver el siguiente resultado:

::

  #!/bin/bash
  
  echo "Hola, mi nombre es Bill. Aquí está el nombre Bill nuevamente."
  
Si quisiera redirigir esta salida a un nuevo archivo de texto, utilizaría este código:

::

  sed "s|Andy|Bill|g" Hola.sh > Hola_Bill.sh
  
Como siempre, puedes llamar al archivo de salida como quieras.

Edición de archivos en el lugar
**********************

Si desea editar el archivo y sobrescribirlo en lugar de redirigir la salida a un nuevo archivo, puede utilizar las opciones -i y -e:

::

  sed -i'' -e "s|Andy|Bill|g" Hola.sh

La opción -i significa "in situ" e indica que el archivo de texto debe sobrescribirse después de intercambiar las palabras. El "''" después de -i es un argumento nulo que impide que sed cree una copia de seguridad del archivo antes de modificarlo.

Si desea crear una copia de seguridad, puede escribir algo como:

sed -i- -e "s|Andy|Bill|g" Hola.sh
Esto creará un archivo llamado “Hello.sh-“ con el contenido original de Hello.sh.

Estoy en deuda con Charles Antonelli del Departamento de Computación de Investigación Avanzada de la Universidad de Michigan por estos ejemplos.


Uso de sed con bucles for
************************

Al igual que con otros comandos, sed puede combinarse con bucles for y sentencias condicionales para escribir código más sofisticado. Por ejemplo, supongamos que queremos crear varias copias de un archivo de plantilla y modificar solo una palabra en una lista de nombres. Comencemos creando un archivo llamado ``Names.sh`` que contenga lo siguiente:

::

  #!/bin/bash
  
  echo "Hola, mi nombre es CHANGENAME."
  

Aquí, CHANGENAME es un marcador de posición; lo escribí en mayúsculas para que resaltara, lo cual es especialmente útil en archivos de texto grandes. Ahora podemos usar un bucle for para crear varias copias de este archivo, reemplazando CHANGENAME con el nombre que esté en el bucle:

::

  para el nombre de Andy John Bill; hacer
    sed -i -e "s|CAMBIARNOMBRE|${nombre}|g" Nombres.sh > ${nombre}_Nombres.sh
  hecho
  
Antes de escribir este código y ejecutarlo, piense en lo que ocurrirá. Visualice cómo los elementos de la lista reemplazarán la variable ${name} y cómo esta se intercambiará con CHANGENAME en el archivo Names.sh.

Ahora ejecuta el código. ¿Obtienes el resultado esperado? ¿Por qué sí o por qué no?


----------

Ceremonias
*********

1. El comando sed puede usar cualquier carácter como separador de archivos; por ejemplo, pruebe este código con el script Hello.sh:

::

  sed "s/nombre/apellido/g" Hola.sh
  
Ahora reemplaza la barra diagonal por otro carácter. ¿Qué separadores (también conocidos como delimitadores) parecen mejores que otros? ¿Por qué? ¿Cuándo podría ser problemático usar una barra diagonal como separador?


2. Puede eliminar una línea en sed cambiando la última «g» por una «d». Al usar sed para eliminar una línea, debe 1) eliminar la «s» inicial y 2) usar solo barras diagonales como delimitadores. Por ejemplo, si desea eliminar una línea que contiene la cadena «nombre», escriba:

::

  sed "/nombre/d" Hola.sh

Sabiendo esto, descargue el programa `Make FSL Timings
    `__ script y use sed para eliminar cualquier línea que contenga la cadena ``run-1``. Compare la salida con el contenido del script antes de ejecutar sed.

---------

Video
***********

Haga clic aquí
     `__ para ver una descripción general en formato screencast del comando sed.




     
    
   


