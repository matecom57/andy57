

.. _Punto de control.rst


Punto de control: preprocesamiento
==========

Ahora es un buen momento para repasar lo que hemos hecho hasta ahora:

1. Descargamos un conjunto de datos fMRI que tiene imágenes anatómicas y funcionales;

2. Miramos los datos en FSLeyes, el visor de datos de FSL;

3. Preprocesamos los datos utilizando FEAT, la herramienta de preprocesamiento de FSL.


Durante el proceso, aprendiste a revisar las imágenes antes y después de cada paso de preprocesamiento. Al aplicar los mismos controles de calidad a diferentes conjuntos de datos, te encontrarás con imágenes difíciles de evaluar; pueden parecer estar en el límite entre lo aceptable y lo inaceptable.

Al principio puede resultar confuso. Pero con el tiempo, desarrollarás tu criterio sobre qué imágenes son claramente buenas, cuáles son obviamente malas y cuáles debes considerar cuidadosamente antes de conservarlas o descartarlas. Cuanto más pienses en por qué los resultados de un preprocesamiento se ven bien o mal, más fácil te resultará tomar decisiones con mayor rapidez y precisión.


Pruebe los siguientes ejercicios para aumentar su fluidez con FSL y mejorar su juicio sobre el resultado de cada paso.

-----------

Ceremonias
********

1. Ejecute BET en la imagen anatómica ``sub-08_T1w.nii.gz`` con dos umbrales de intensidad fraccional: 0,1 y 0,9. Tome una instantánea de cada imagen de salida con FSLeyes usando el botón de la cámara (ubicado en la parte superior central del visor). Observe las diferencias entre ambas. ¿El resultado es el esperado? Si tuviera que usar una u otra imagen, ¿cuál elegiría?

2. Preprocese la segunda ejecución de los datos funcionales mediante la interfaz gráfica de usuario de FEAT. Para ello, seleccione ``sub-08_task-flanker_run2.nii.gz`` en el directorio ``func``, cambie el directorio de salida a ``run2`` y asegúrese de que ``Preprocesamiento`` esté seleccionado en el menú desplegable. Mantenga los demás ajustes como en el análisis de la primera ejecución. Realice las mismas comprobaciones de calidad que para la primera ejecución.

3. Preprocese la primera ejecución con un kernel de suavizado de 3 mm, manteniendo las demás opciones de preprocesamiento iguales. (Asegúrese, sin embargo, de cambiar el nombre del directorio de salida para mantener la salida organizada). Antes de examinar la salida, ejecute otro análisis con un kernel de suavizado de 12 mm. Piense en cómo esperaría que se vieran los datos funcionales preprocesados y luego cargue las imágenes ``filtered_func_data.nii.gz`` de cada análisis en FSLeyes. ¿Cómo se comparan con sus predicciones?

4. Preprocese la ejecución 1 con ``3DOF`` para el registro y la normalización. ¿En qué se diferencia el resultado del preprocesamiento con ``12DOF``? ¿Por qué? (Sugerencia: Revise el registro y la normalización)` página para conocer las posibles razones).

5. Vuelva a ejecutar el registro para la primera ejecución usando ``BBR`` en lugar de ``12DOF``. ¿Qué diferencia hay? ¿Cómo argumentaría a alguien que debería usar uno en lugar del otro?


--------------

Cuando haya terminado de realizar los ejercicios, haga clic en el botón Siguiente para comenzar el módulo sobre Estadística y Modelado.

.. advertencia::

  Asegúrese de haber preprocesado tanto ``run1`` como ``run2`` antes de continuar; necesitará ambos para ejecutar un análisis de nivel superior y utilizar los scripts que se proporcionan en ``Github``.
    `__.

    
   

