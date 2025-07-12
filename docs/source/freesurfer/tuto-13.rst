Tutorial de FreeSurfer n.° 13: Errores en la superficie de la piel y en el cráneo
===============================================================

---------------

Desprendimiento del cráneo
***************

Uno de los primeros pasos de preprocesamiento en recon-all es :ref:`**skull-strip**La imagen anatómica. Esto elimina tanto el cráneo como cualquier otra parte de la imagen que no sea materia gris o blanca, como los ojos, el cuello, las orejas y la duramadre, lo que permite a recon-all trazar un límite más preciso de la superficie pial.

.. figura:: 13_SkullStripping_BeforeAfter.png

  Imagen anatómica ponderada en T1 antes y después de la extracción del cráneo. A la derecha, el contorno de la superficie pial se traza en rojo.

Se debe revisar la superficie pial tras la extracción del cráneo para determinar si se eliminó corteza durante la extracción o si se extrajo suficiente tejido no cerebral. En este último caso, la superficie pial puede incluir parte de la duramadre o del cráneo, lo que puede inflar la estimación de la cantidad de corteza en esa región.

.. nota::

  Incluso si no se eliminó todo el material no cerebral durante la extracción del cráneo, eso no es problema siempre que se haya trazado correctamente la superficie pial.
  
Establecimiento del umbral de la cuenca hidrográfica
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Una forma de controlar la cantidad de cráneo que se elimina es ajustando un parámetro llamado **umbral de cuenca**. Durante la autorecon1 de recon-all, el cráneo se elimina utilizando un umbral de cuenca de 25; este parámetro puede tomar cualquier valor entre 0 y 50. Aumentar el umbral aumentará la probabilidad de que se conserven tanto el cerebro como el cráneo (es decir, se eliminará el cráneo con mayor cautela), mientras que disminuirlo provocará una eliminación más agresiva.

En nuestro conjunto de datos, el sujeto 117 aún conserva gran parte del cráneo. Puede consultarlo accediendo al directorio ``sub-117_ses-BL_T1w`` y escribiendo:

::

  freeview -v mri/brainmask.mgz -f surf/lh.pial:edgecolor=rojo surf/rh.pial:edgecolor=rojo
  
Esto mostrará la imagen brainmask.mgz con las superficies piales superpuestas. La tira de cráneo de este sujeto no eliminó partes del cráneo frontal ni grandes porciones del cuello, como se muestra a continuación:

.. figura:: 13_sub117_Skull.png

Podemos eliminar más del cráneo estableciendo un umbral de cuenca hidrográfica más bajo, como 5. Para ello, navegue hasta el directorio del tema y escriba lo siguiente:

::

  recon-all -skullstrip -wsthresh 5 -clean-bm -s sub-117_ses-BL_T1w
  
Esto creará un nuevo archivo brainmask.mgz, al que ahora se le ha quitado una mayor parte del cráneo. Puede examinar los cambios con el mismo comando freeview mencionado anteriormente.

.. figura:: 13_sub117_wsThresh_5.png
  :escala: 50%


Usando la opción -gcut
^^^^^^^^^^^^^^^^^^^^^^

Incluso con un umbral de cuenca hidrográfica más bajo, aún quedan fragmentos de cráneo y duramadre. Puede usar la opción -gcut para eliminar estos últimos:

::

  recon-all -skullstrip -clean-bm -gcut -subjid sub-117_ses-BL_T1w
  
Sin embargo, si ejecuta este comando, después de unos momentos verá este mensaje de error:

::

  **¡El cerebro cortado es mucho más pequeño que la máscara!
  ** ¡Utilizando la máscara como salida en su lugar!

Esto indica que se extirpó una parte excesiva del cerebro (normalmente el cerebelo) y que el comando utilizó por defecto el archivo brainmask.mgz original. Esto suele ser un problema con imágenes que conservan demasiado cráneo o cuello, incluso después de la extracción del cráneo; la opción -gcut no funciona con estos sujetos.

Para ilustrar los resultados de gcut, lo usaremos con un sujeto diferente, el número 119. Primero, abra el archivo ``brainmask.mgz`` del sujeto y busque regiones rodeadas por grandes cantidades de duramadre. Luego, ejecute el siguiente comando desde el directorio del sujeto:

::

  recon-all -skullstrip -clean-bm -gcut -subjid sub-119_ses-BL_T1w
  
Para examinar cuánta duramadre se eliminó, cargue los archivos ``brainmask.mgz``, ``T1.mgz`` y ``brainmask.gcuts.mgz`` en Freeview:

::

  freeview -f mri/brainmask.mgz mri/T1.mgz mri/brainmask.gcuts.mgz:mapa de colores=LUT
  
Esto mostrará las regiones extirpadas en fucsia; utilice el control deslizante de superposición para examinar dónde la escisión de la duramadre pudo haber cortado la corteza, como en el área frontal. En este sujeto, la opción de corte longitudinal (gcut) es eficaz para extirpar la duramadre, pero también ha extirpado pequeñas porciones de cerebro.

.. figura:: 13_gcut_sub119.png
  :escala: 50%


.. nota::

  Después de utilizar las opciones de cuenca hidrográfica o gcut, deberá regenerar las superficies pial con el siguiente código:
  
  recon-all -autorecon-pial -subjid
    
  

Errores de la superficie pial
*******************


Un problema relacionado es la imprecisión de la superficie pial, que puede deberse a fallos en la extracción del cráneo o de la duramadre. Sin embargo, como hemos visto, las soluciones para estos fallos pueden eliminar la corteza, lo que también puede resultar en una estimación inexacta de la superficie pial. Un método más preciso consiste en eliminar manualmente las partes de la superficie que trazan partes del cráneo o la duramadre cercanos.

En este ejemplo, volvamos al sujeto 117 (``cd sub-117_ses-BL_T1w``). Cargue la imagen ``brainmask.mgz`` y las superficies piales del sujeto con este comando:

::

  freeview -v mri/brainmask.mgz -f surf/lh.pial:edgecolor=rojo surf/rh.pial:edgecolor=rojo surf/lh.white:edgecolor=amarillo surf/rh.white:edgecolor=amarillo
  
En el corte 128 del panel de visualización Coronal, observará que la superficie pial (marcada en rojo) parece incluir partes del cráneo. Nuestro objetivo es eliminar estos vóxeles con la herramienta "Edición de Reconocimiento", cuyo icono en la esquina superior izquierda muestra el contorno de una cabeza con una "R". Asegúrese de que el volumen de la máscara cerebral esté resaltado en la barra lateral y, a continuación, haga clic en el botón "Edición de Reconocimiento" y asegúrese de que la casilla "Edición de Reconocimiento" esté marcada. En el panel de visualización, amplíe la superficie pial que contiene el cráneo, mantenga pulsada la tecla Mayús y, a continuación, haga clic y arrastre para eliminar los vóxeles que se hayan clasificado erróneamente como superficie pial.

.. figura:: 13_PialSurface_Edit.png

  Ejemplo de edición de la superficie pial. El área marcada con el círculo naranja indica una región donde la superficie pial incluye el cráneo; los vóxeles del cráneo deben borrarse durante la edición.

.. nota::

  Aunque a veces puede ser difícil determinar qué es cráneo y qué es corteza, normalmente los vóxeles del cráneo son ligeramente más brillantes que sus vecinos. Sea prudente con las ediciones y evalúe si el nuevo contorno es más anatómicamente correcto que el anterior.


La superficie pial de esta parte del cráneo se mostrará desde los cortes 128 hasta aproximadamente el 117. Probablemente también verá otras áreas que requieren edición. Cuando haya terminado de editar, vuelva a ejecutar recon-all con este comando:

::

  recon-all -s sub-117_ses-BL_T1w -autorecon-pial

Como siempre, revise las superficies regeneradas para asegurarse de que sean una mejora.

.. figura:: 13_PialSurface_Edit_Before_After.png

  Ejemplo de la reconstrucción de la superficie antes (panel izquierdo) y después de las ediciones de la superficie pial (panel derecho).

---------


Video
*****

Para ver una descripción general en video sobre cómo corregir errores de extracción del cráneo y de la superficie pial, haga clic aquí
     `__.

     
    
   

