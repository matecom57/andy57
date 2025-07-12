

.. _Corrección_de_movimiento:

Capítulo 3: Corrección de movimiento
^^^^^^^^^^

Si alguna vez has intentado fotografiar un objeto en movimiento, la imagen suele salir borrosa. En cambio, si el objeto está inmóvil, obtendrás una imagen mucho más clara y nítida.


.. figura:: Movimiento_de_mano.png

  Un objetivo en movimiento produce una imagen borrosa (izquierda), mientras que un objetivo estacionario produce una imagen más claramente definida (derecha).
  
El concepto es el mismo al tomar imágenes tridimensionales del cerebro. Si el sujeto se mueve, las imágenes se verán borrosas; si está inmóvil, se verán más definidas. Pero eso no es todo: si el sujeto se mueve mucho, también corremos el riesgo de medir la señal de un vóxel que se mueve. En ese caso, corremos el riesgo de medir la señal del vóxel durante parte del experimento y, después de que el sujeto se mueva, de una región o tipo de tejido diferente.

.. Podría incluirse aquí una animación que ilustre el párrafo anterior.

Por último, el movimiento puede introducir confusiones en los datos de imagen, ya que genera señales. Si el sujeto se mueve constantemente en respuesta a un estímulo (por ejemplo, si sacude la cabeza cada vez que siente una descarga eléctrica), puede resultar imposible determinar si la señal que medimos responde al estímulo o se debe al movimiento.

Una forma de "deshacer" estos movimientos es mediante **transformaciones de cuerpo rígido**. Para ilustrarlo, tome un objeto cercano: un teléfono o una taza de café, por ejemplo. Colóquelo frente a usted y marque mentalmente dónde está. Este es el **punto de referencia**. Luego, mueva el objeto unos centímetros a la izquierda. Esto se llama **traslación**, que significa cualquier movimiento hacia la izquierda o la derecha, hacia adelante o hacia atrás, hacia arriba o hacia abajo. Si desea que el objeto regrese a su punto de partida, simplemente muévalo unos centímetros a la derecha.

De forma similar, si rotaste el objeto a la izquierda o a la derecha, podrías deshacerlo girándolo la misma cantidad en la dirección opuesta. Estas rotaciones se llaman **rotaciones** y, al igual que las traslaciones, tienen tres **grados de libertad**, o formas de moverse: alrededor del eje x (también llamado **cabeceo**, o inclinación hacia adelante y hacia atrás), alrededor del eje y (también conocido como **balanceo**, o inclinación a la izquierda y a la derecha) y alrededor del eje z (o **guiñada**, como al negar con la cabeza).

.. nota::

  Experimenta con estas traslaciones y rotaciones moviendo la cabeza. Primero, mueve la cabeza de lado a lado mientras miras al frente (traslación a lo largo del eje x). Luego, mueve la cabeza hacia adelante y hacia atrás (eje y) y hacia arriba y hacia abajo (eje z). Prueba también las rotaciones.

Realizamos el mismo procedimiento con nuestros volúmenes. En lugar del punto de referencia que usamos en el ejemplo anterior, llamaremos al primer volumen de nuestra serie temporal **volumen de referencia**. Si en algún momento del escaneo nuestro sujeto mueve la cabeza unos centímetros a la derecha, podemos detectar ese movimiento y corregirlo moviendo ese volumen unos centímetros a la izquierda. El objetivo es detectar movimientos en cualquiera de los volúmenes y **realinearlos** con el volumen de referencia.

.. figura:: MotionCorrectionExample.gif

  El volumen de referencia puede ser cualquier volumen de la serie temporal (aunque normalmente es el primero, el intermedio o el último). Si durante la exploración el sujeto se mueve hacia la derecha, ese movimiento puede revertirse con respecto al volumen de referencia mediante un movimiento igual y opuesto hacia la izquierda.
  
En la interfaz gráfica de FEAT, la corrección de movimiento se especifica en la pestaña "Pre-stats". FEAT usa por defecto la herramienta MCFLIRT de FSL, que se encuentra en el menú desplegable. Puedes desactivar la corrección de movimiento, pero a menos que tengas una razón para hacerlo, déjala como está.

.. figura:: FEAT_MCFLIRT.png
  :escala: 60 %


La pestaña Preestadísticas contiene otras opciones de preprocesamiento, como la corrección de la sincronización de cortes y el suavizado. Para obtener una descripción general de la corrección de la sincronización de cortes, haga clic en el botón Siguiente.

