

.. _Unix_03_Lectura de archivos de texto:

=======
Tutorial de Unix n.º 3: Lectura de archivos de texto
=======

.. nota::
   Temas tratados: Manipulación de archivos, redirección, flujos, stdin, stdout, stderr
   
   Comandos utilizados: gato, menos, cabeza, wc

La línea de comandos es útil tanto para visualizar como para manipular archivos de texto. **Manipular** significa editar texto; por ejemplo, reemplazar palabras en archivos de texto o añadir texto desde la línea de comandos al final de un archivo (también conocido como **redirección**). Esto es útil para crear **scripts**, archivos de texto que contienen uno o más comandos que se ejecutan consecutivamente. En tutoriales posteriores, utilizará estas técnicas para automatizar sus análisis, lo que puede ahorrarle mucho tiempo.

Puedes visualizar el contenido de un archivo usando el comando ``cat``, que significa concatenar. Supongamos que tenemos un archivo en el escritorio llamado myFile.txt, que contiene las palabras del uno al quince (es decir, uno, dos, tres... quince), con cada número en una línea aparte. Usa la línea de comandos para navegar al escritorio y escribe ``cat myFile.txt``. Esto mostrará el contenido del archivo en la línea de comandos. Es similar a usar la interfaz gráfica para hacer doble clic en el archivo de texto y ver su contenido.

.. figura:: Cat_File.png

   Uso de la línea de comandos y la interfaz gráfica de usuario para leer el contenido de un archivo de texto. A la izquierda se muestra la línea de comandos con el comando ``cat``, que imprime el contenido en la terminal. A la derecha se muestra el contenido del archivo tras hacer doble clic con el ratón.

Nos referimos a la salida de este comando como **stdout**, o salida estándar. Los comandos que se escriben en la Terminal se llaman **stdin**, o entrada estándar. Esto aborda el concepto de **streams**, o el flujo de información que entra y sale de la línea de comandos, y usaremos estas ideas para mayor flexibilidad al manipular archivos de texto. Por ahora, piense en **stdin** como cualquier cosa que escriba en la Terminal, y en **stdout** como lo que se devuelve si el comando se ejecuta sin errores. Si el comando que escribe genera un error (por ejemplo, porque está mal escrito o porque no se proporcionaron suficientes argumentos), el texto que se muestra en la Terminal se llama **stderr**, o error estándar.

.. figura:: Streams.png

   Ilustración de flujos en Unix. Todo lo que se escribe en la terminal se llama **stdin** y, si se ejecuta sin errores, la salida se llama **stdout**. Si hay un error, la salida se llama **stderr**.

   
El comando ``cat`` es útil para ver el contenido de archivos pequeños, pero si el archivo contiene cientos de líneas de texto, resulta abrumador tener que imprimirlo todo en la Terminal de una sola vez. Para ver solo una parte del archivo, podemos usar los comandos ``head`` y ``tail`` para ver las primeras o las últimas líneas, respectivamente. Usando myFile.txt como ejemplo, escriba

::

   encabezado miArchivo.txt


Devolvería las primeras cinco líneas; mientras que escribir

::

   cola miArchivo.txt


Devolvería las últimas cinco líneas. Aunque el valor predeterminado es devolver cinco líneas, estos comandos tienen la opción de mostrar cualquier número de líneas que elija. Por ejemplo,

::

   encabezado -10 miArchivo.txt
   cola -10 miArchivo.txt


Devolvería las diez primeras y las diez últimas líneas. Pruébelo usted mismo, modificando el número de líneas que se muestran.


Redirección
----------

Además de mostrar los resultados de un comando, la salida estándar (stdout) se puede usar para mover o anexar la salida a un archivo, un concepto conocido como redirección. Por ejemplo, si escribe

::

   echo dieciséis > tmp.txt


La palabra "dieciséis" se guarda en el archivo tmp.txt en lugar de escribirse en la salida estándar. Observe que crea el archivo tmp.txt incluso si no existe. Sin embargo, si lo intentamos de nuevo con otra cadena, por ejemplo,

::

   echo diecisiete > tmp.txt


Sobrescribirá el archivo con lo que imprimimos en la salida estándar. Si desea añadir la salida estándar al final de un archivo sin sobrescribir los demás datos, utilice dos signos mayor que. Por ejemplo, escriba

::

   eco dieciocho >> tmp.txt


Si escribes «cat tmp.txt», verás diecisiete y dieciocho.

Aunque estos ejemplos son triviales, la redirección es invaluable para editar rápidamente archivos de texto y para escribir **scripts**, que le permiten ejecutar análisis para cientos o miles de sujetos con solo unas pocas líneas de código.



Video
----------

Haga clic aquí`__ para un video tutorial sobre los comandos para leer archivos de texto. Este video también muestra cómo leer archivos de ayuda usando el comando ``less`` y una ventana de paginación.


----------


Ceremonias
----------

1. Cree un nuevo archivo llamado "tmp.txt" y escriba lo que desee. Use ``cat`` para enlazar los archivos `myFile.txt` y `tmp.txt` y redirigir la salida para crear un nuevo archivo. Imprima el contenido del nuevo archivo en la salida estándar.

2. Si tiene AFNI instalado en su equipo, use ``less`` en el comando ``3dcalc`` para encontrar cadenas que coincidan con "Example". Ahora, inténtelo usando el comando ``less`` con una opción para ignorar si las letras de la cadena están en mayúsculas o minúsculas. Consejo: Para encontrar esta opción, busque la cadena "case" en el archivo ``man`` correspondiente a ``less``. (Si tiene FSL instalado en lugar de AFNI, intente el mismo ejercicio con el comando ``fslmerge``).

3. Unix tiene un comando integrado llamado ``sort`` que ordena el texto numérica o alfabéticamente. ¿Qué ocurre al usar ``myFile.txt`` como argumento para ``sort``? ¿Qué tal si escribes este comando?

::

   cat miArchivo.txt | ordenar

Con tus propias palabras, explica la diferencia entre los dos métodos.

   

