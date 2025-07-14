

.. _02_SPM_Tiempo de corte:

==================================
Capítulo 2: Corrección de la sincronización de segmentos
==================================

-------------


Fondo
*********

A diferencia de una fotografía, donde la imagen completa se toma en un solo instante, el volumen de fMRI se adquiere en cortes. Cada uno de estos cortes tarda en adquirirse, desde decenas hasta cientos de milisegundos.

Los dos métodos más comunes para crear volúmenes son la adquisición secuencial y la intercalada de cortes. La adquisición secuencial de cortes adquiere cada corte adyacente consecutivamente, ya sea de abajo a arriba o de arriba a abajo. La adquisición intercalada de cortes adquiere cada corte de por medio y luego rellena los espacios vacíos en la segunda pasada. Ambos métodos se ilustran en el video a continuación.

.. figura:: 04_02_SliceTimingCorrection_Demo.gif


.. nota::

  Para ver otra ilustración de cómo funciona la sincronización de segmentos mediante **interpolación lineal**, consulte la página de Matthew Brett`__.

Como verá más adelante, al modelar los datos en cada vóxel, asumimos que todos los cortes se adquirieron simultáneamente. Para que esta suposición sea válida, la serie temporal
    `Para cada segmento, es necesario retroceder en el tiempo el tiempo que llevó obtenerlo. `Sladky et al. (2011) 
     `__ también demostró que la corrección del tiempo de corte puede conducir a aumentos significativos en el poder estadístico para estudios con TR más largos (por ejemplo, 2 s o más), y especialmente en las regiones dorsales del cerebro.



Aunque la corrección del tiempo de corte parece razonable, existen algunas objeciones:

1. En general, es mejor no interpolar (es decir, editar) los datos a menos que sea necesario;

2. Para TR cortos (por ejemplo, alrededor de 1 segundo o menos), la corrección del tiempo de corte no parece conducir a ninguna ganancia significativa en potencia estadística; y

3. Muchos de los problemas abordados mediante la corrección del tiempo de corte se pueden resolver utilizando una **derivada temporal** en el modelo estadístico (que se analiza más adelante en el capítulo sobre ajuste de modelos).


Por ahora, haremos una corrección del tiempo de corte, usando el primer corte como referencia.


Corrección de tiempos de corte en SPM
************************************

Similar a lo que hicimos con :ref:`Realignment <01_SPM_RealignUnwarp>`, primero haremos clic en el botón ``Slice Timing`` en la interfaz gráfica de SPM. Haga clic en el campo ``Datos`` y cree dos nuevas sesiones. Haga doble clic en la primera sesión y, en la columna Filtro, escriba ``^rsub-08_task-flanker_run-1.*``. En el campo Fotogramas, escriba ``1:146`` y presione Intro; seleccione todos los fotogramas que se muestran y haga clic en ``Listo``. Repita el mismo procedimiento con los archivos de la segunda sesión.

Para el campo "Número de porciones", necesitamos averiguar cuántas porciones hay en cada volumen de nuestro conjunto de datos. Desde la terminal de Matlab, navegue al directorio "sub-08/func" y escriba:

::

  V = spm_vol('sub-08_tarea-flanker_run-1_bold.nii')
  
Esto cargará el **encabezado** de la imagen en una variable llamada ``V``. Si escribe ``V`` y pulsa Intro, verá que contiene los siguientes campos:

::

    nombre
    oscuro
    dt
    pinfo
    estera
    norte
    describir
    privado
    
``fname`` es el nombre del archivo y ``dim`` contiene las dimensiones de cada volumen del archivo. (No analizaremos los demás campos por ahora; solo necesita saber que contienen información adicional del encabezado que SPM necesita para leer el archivo). Si escribe
 
::

  V(1).dim

Devolverá las dimensiones del primer volumen de la serie temporal en las direcciones x, y y z. Debería ver algo como esto:

::

  64 64 40
  
Esto significa que el primer volumen de la serie temporal tiene unas dimensiones de 64x64x40 vóxeles, siendo 40 el número de cortes en las dimensiones z. Supondremos que las dimensiones de cada imagen y el número de cortes serán los mismos para todos los volúmenes de los datos funcionales del sujeto.

Ahora regrese a la ventana del Editor de lotes, haga doble clic en “Número de porciones”, ingrese un valor de “40” y haga clic en “Aceptar”.

Para el TR, introduzca 2; para el TA, siga la fórmula de la ventana de ayuda e introduzca ``2-(2/40)``. Para el orden de corte, introduzca ``[1:2:40 2:2:40]``, y para el corte de referencia, introduzca ``1``. Deje el prefijo del nombre de archivo como está, ya que se añadirá una ``a`` a los archivos generados. Repita el mismo procedimiento para la ejecución 2. Al finalizar, la ventana de preprocesamiento debería verse así:

.. figura:: 04_02_SliceTimingWindow.png

Cuando se hayan corregido los tiempos de corte de las imágenes, estará listo para **corregistrar** los datos funcionales con los datos anatómicos; en otras palabras, alinearemos los dos conjuntos de imágenes lo mejor que podamos.


Ceremonias
*********

1. A veces, los cortes se adquieren de abajo hacia arriba del volumen, sin intercalación. ¿Cómo modificarías el código para que el orden de los cortes refleje esto? Muestra el vector que usarías en este caso.

2. Ahora realice las mismas modificaciones, pero para los cortes intercalados desde la parte superior del volumen hasta la inferior. Muestre el vector.

3. Descargue otra ejecución funcional de un estudio aleatorio en openneuro.org y use ``spm_vol`` para determinar cuántos cortes hay. Repita los ejercicios 1 y 2 para este nuevo conjunto de datos. Incluya el código y la salida de ``spm_vol``, junto con los vectores que usaría.

     
    
   

