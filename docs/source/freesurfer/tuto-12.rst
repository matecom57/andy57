Tutorial de FreeSurfer n.° 12: Introducción a los modos de fallo
======================================================

---------------

Descripción general
********

Si sus datos anatómicos son de buena calidad (fuerte contraste entre los tipos de tejido, ausencia de movimiento y alta resolución), recon-all probablemente se ejecutará sin errores y generará superficies que siguen con precisión los bordes de los diferentes tipos de tejido. Es posible que observe pequeñas discrepancias entre los bordes dibujados por FreeSurfer y los límites reales entre la materia gris y la blanca; pero mientras las discrepancias sean relativamente pequeñas y poco frecuentes, es mejor no modificarlas. En esos casos, a veces editar las superficies puede empeorar el problema, en lugar de solucionarlo.

Sin embargo, en algunos sujetos, recon-all no podrá terminar de reconstruir las superficies; o, si lo hace, a veces las discrepancias son tan grandes que requieren ediciones manuales. Un ejemplo de estos problemas es la aparición de agujeros en la superficie de la materia blanca reconstruida, lo que puede alterar los cálculos del espesor y el volumen de la materia gris cercana. Estos **Modos de Fallo** ocurren cuando un problema provoca que recon-all se cierre prematuramente o requiere ediciones manuales.

.. figura:: 12_Hoyos.png
  :escala: 50%


Fracasos duros vs. fracasos leves
*******************************

Los modos de fallo se pueden dividir en dos categorías: **Fallos graves** y **Fallos leves**. Los fallos graves ocurren cuando recon-all sale de su flujo de preprocesamiento debido a uno de estos escenarios:

1. No hay permiso de escritura en el disco actual (para solucionar esto, consulte el archivo de ayuda del comando ``chmod``);
2. Espacio en disco insuficiente; o
3. Problemas con la imagen anatómica, como demasiado movimiento.

Los escenarios 1 y 2 son fáciles de resolver, pero el 3 puede ser difícil e incluso imposible de solucionar. Es mejor evitar que ocurra el escenario 3 asegurándose de que el sujeto permanezca inmóvil durante la exploración anatómica y revisando los cortes a medida que el escáner los adquiere.

Por otro lado, las fallas leves ocurren cuando la reconstrucción completa ha finalizado sin errores, pero al observar más de cerca el resultado, se detectan errores obvios que deben corregirse. Estos incluyen grandes agujeros en la sustancia blanca (errores de segmentación de la sustancia blanca) y grandes discrepancias entre el borde de la sustancia blanca y gris del volumen anatómico y la superficie reconstruida (errores de la superficie pial).

.. figura:: 12_WM_Pial_Surface_Errors.png

  Ejemplos de errores en la sustancia blanca y en la superficie pial.
  

Tipos de fallos leves
******************

Dado que las fallas leves son más comunes, conviene familiarizarse con sus diferentes tipos. Estas fallas se pueden clasificar en las siguientes categorías:

1. Errores en el desprendimiento del cráneo;
2. Errores de la superficie pial;
3. Errores de normalización de intensidad;
4. Defectos topológicos; y
5. Errores de segmentación de la sustancia blanca.


Unas palabras sobre los dos últimos tipos de errores. Los **defectos topológicos** se refieren a agujeros perforados en la superficie de la sustancia blanca reconstruida o a falsos "mangos" de materia gris que unen las circunvoluciones. Estos aparecerán en las superficies de la sustancia blanca del directorio ``surf``. Desde el lanzamiento de la versión 6.0 de FreeSurfer, estos tipos de errores son muy poco frecuentes y suelen corregirse automáticamente durante la reconstrucción total. Puede ver cómo se corrigen estos defectos cargando los archivos ``lh.smoothwm.nofix`` y ``lh.white`` en Freeview y alternando entre ellos.

.. figura:: 12_lh_smoothwm_nofix.png

  Ejemplo de defectos topológicos en la superficie de la sustancia blanca, que normalmente se corrigen mediante recon-all.
  
Los errores de segmentación de la sustancia blanca, por otro lado, ocurren en el *volumen* de la imagen anatómica (no en la superficie reconstruida). Estos se asemejan a los agujeros que se muestran en la figura de la sección anterior y suelen estar causados por lesiones o gliomas en la sustancia blanca. Son relativamente poco frecuentes en sujetos sanos y no se abordarán en este curso. Para obtener una guía sobre cómo corregir estos errores, consulte esta página de FreeSurfer.`__.


Visualización de los otros errores
************************

Los errores leves restantes (desprendimiento del cráneo, superficie pial y normalización de la intensidad) son los más comunes, incluso con datos de alta calidad. Para empezar a buscar estos errores, cargaremos las imágenes T1 y de máscara cerebral como capas subyacentes en vista libre y superpondremos las superficies blanca y pial de ambos hemisferios. Aquí tiene un comando de ejemplo que puede usar (reemplazando "[sujeto]" por el nombre del sujeto que está observando):

::

  freeview -v [asunto]/mri/T1.mgz \
  [asunto]/mri/brainmask.mgz \
  -f [asunto]/surf/lh.pial:edgecolor=rojo \
  [asunto]/surf/lh.white:edgecolor=amarillo \
  [asunto]/surf/rh.pial:edgecolor=rojo \
  [asunto]/surf/rh.white:edgecolor=amarillo
  
  
Esto dibujará el límite de la superficie pial en rojo y la superficie de la sustancia blanca en amarillo. Tras ejecutar el comando, debería ver algo similar a esto en Freeview:

.. figura:: 12_Freeview_Surfaces.png

Mientras observa los cortes, tenga en cuenta que, aunque un corte pueda parecer incorrecto (por ejemplo, parece haber una "isla" de materia blanca dentro de una circunvolución), recuerde que estamos viendo una imagen tridimensional a través de cortes bidimensionales. Si la anomalía se resuelve en uno o dos cortes siguientes, probablemente se deba a que la materia blanca se proyecta en una dirección ortogonal al corte que está observando.

.. figura:: 12_FailureModes_Slices.png

  Ejemplo de dos cortes coronales contiguos. La sustancia blanca dentro de la circunvolución en el corte A parece estar separada de la sustancia blanca circundante; sin embargo, la conexión se resuelve en el corte B. En este caso, no se requiere edición manual de la imagen.
  

Tenga en cuenta también que las superficies dibujadas en la pared medial cerca de los ventrículos y el cuerpo calloso, y las superficies dibujadas cerca de las estructuras subcorticales, no se utilizarán en los cálculos de superficie finales y se pueden ignorar durante la edición.

.. figura:: 12_Ignorar_Superficies.png
  :escala: 50%


Próximos pasos
*********

Cualquier otra edición se realizará mediante uno o más de los siguientes pasos:

1. Borrar vóxeles;
2. Relleno de vóxeles;
3. Agregar puntos de control;
4. Clonación de vóxeles.

Veremos cómo utilizar cada una de estas herramientas y cuándo son necesarias en los próximos dos capítulos.


-----------

Video
*****

Para ver una descripción general en video de los modos de falla, haga clic aquí
    `__.

    
   

