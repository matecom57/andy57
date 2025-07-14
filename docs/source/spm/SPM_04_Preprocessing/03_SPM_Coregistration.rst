

.. _03_SPM_Corregistro:

=========================
Capítulo 3: Corregistro
=========================

-------------

Descripción general
********

Aunque el cerebro de la mayoría de las personas es similar (por ejemplo, todos tenemos una circunvolución cingulada y un cuerpo calloso), también existen diferencias en el tamaño y la forma cerebrales. Por lo tanto, si queremos realizar un análisis grupal, debemos asegurarnos de que cada vóxel de cada sujeto corresponda a la misma parte del cerebro. Si medimos un vóxel en la corteza visual, por ejemplo, debemos asegurarnos de que la corteza visual de cada sujeto esté alineada.

Esto se hace **Registrando** y **Normalizando** las imágenes. Tal como doblarías la ropa para que quepa dentro de una maleta, cada cerebro necesita ser transformado para tener el mismo tamaño, forma y dimensiones. Hacemos esto normalizando (o **deformando**) a una **plantilla**. Una plantilla es un cerebro que tiene dimensiones y coordenadas estándar; estándar, porque la mayoría de los investigadores han acordado usarlas al informar sus resultados. De esa manera, si normalizas tus datos a esa plantilla y encuentras un efecto en las coordenadas X=3, Y=20, Z=42, alguien más que haya deformado sus datos a la misma plantilla puede comparar sus resultados con los tuyos. Las dimensiones y coordenadas del cerebro plantilla también se conocen como **espacio estandarizado**.

.. figure:: 04_03_MNI_Template.png

  Un ejemplo de una plantilla de uso común, el cerebro :ref:`MNI152`. Este es un promedio de 152 cerebros adultos sanos, que representan la población de la que se extraen la mayoría de los estudios. Si está estudiando otra población, como niños o ancianos, por ejemplo, considere usar una plantilla creada con representantes de esa población. (Pregunta: ¿Por qué está borrosa la plantilla?)
  
Transformaciones afines
****************

Para deformar las imágenes según una plantilla, usaremos una **transformación afín**. Esta es similar a la transformación de cuerpo rígido descrita anteriormente en Corrección de movimiento, pero añade dos transformaciones más: **zooms** y **cortes**. Mientras que las traslaciones y rotaciones son fáciles de realizar con un objeto cotidiano como un bolígrafo, los zooms y los cortes son más inusuales: los zooms reducen o amplían la imagen, mientras que los cortes toman las esquinas diagonalmente opuestas de la imagen y las estiran. La animación a continuación resume estos cuatro tipos de **transformaciones lineales**.

.. figure:: 04_03_AffineTransformations.gif

.. nota:: Al igual que con las transformaciones de cuerpo rígido, los zooms y los cortes tienen tres grados de libertad: puede hacer zoom o cortar una imagen a lo largo del eje x, y o z. En total, entonces, las transformaciones afines tienen doce grados de libertad. Estas también se llaman transformaciones lineales porque una transformación aplicada en una dirección a lo largo de un eje está acompañada por una transformación de igual magnitud en la dirección opuesta. Una traslación de un milímetro *a* la izquierda, por ejemplo, implica que la imagen se ha movido un milímetro *desde* la derecha. Del mismo modo, si una imagen se amplía un milímetro a lo largo del eje z, se amplía un milímetro en ambas direcciones a lo largo de ese eje. Las transformaciones sin estas restricciones se llaman **transformaciones no lineales**. Por ejemplo, una transformación no lineal puede ampliar la imagen en una dirección mientras la encoge en la otra dirección, como cuando se aprieta una esponja. Estos tipos de transformaciones se tratarán más adelante.

Registro y Normalización
***************

Recuerde que nuestro conjunto de datos incluye imágenes anatómicas y funcionales. Nuestro objetivo es adaptar las imágenes funcionales a la plantilla para realizar un análisis grupal de todos los sujetos. Si bien parece razonable adaptar las imágenes funcionales directamente a la plantilla, en la práctica esto no funciona bien: las imágenes tienen baja resolución y, por lo tanto, es menos probable que coincidan con los detalles anatómicos de la plantilla. La imagen anatómica es una mejor opción.

Aunque esto parezca no ayudarnos a alcanzar nuestro objetivo, de hecho, deformar la imagen anatómica puede ayudar a estandarizar las imágenes funcionales. Recuerde que las exploraciones anatómicas y funcionales suelen adquirirse en la misma sesión, y que la cabeza del sujeto se mueve poco o nada entre las exploraciones. Si ya hemos normalizado nuestra imagen anatómica a una plantilla y registrado las transformaciones realizadas, podemos aplicar las mismas transformaciones a las imágenes funcionales, siempre que comiencen en el mismo lugar que la imagen anatómica.

Esta alineación entre las imágenes funcionales y anatómicas se denomina **Registro**. La mayoría de los algoritmos de registro utilizan los siguientes pasos:

1. Suponga que las imágenes funcionales y anatómicas están prácticamente en la misma ubicación. De no ser así, alinee los contornos de las imágenes.

2. Aproveche que las imágenes anatómicas y funcionales tienen diferentes ponderaciones de contraste; es decir, las áreas oscuras en la imagen anatómica (como el líquido cefalorraquídeo) aparecerán brillantes en la imagen funcional, y viceversa. Esto se denomina **información mutua**. El algoritmo de registro desplaza las imágenes para probar diferentes superposiciones de las imágenes anatómicas y funcionales, haciendo coincidir los vóxeles brillantes de una imagen con los oscuros de otra, y los oscuros con los brillantes, hasta encontrar una coincidencia irreprochable. Este procedimiento también se conoce como **función de coste**.

3. Una vez que se encuentra la mejor coincidencia, se aplican a las imágenes funcionales las mismas transformaciones que se utilizaron para deformar la imagen anatómica a la plantilla.


.. figure:: 04_03_Registro_Normalización_Demo.gif

-----

Co-registro con SPM
************************

Para corregistrar las imágenes funcionales y anatómicas, regrese a la interfaz gráfica de usuario de SPM y haga clic en «Corregistrar (Estimar y Recortar)». Se abrirá una ventana de edición por lotes con solo dos campos para completar: **Imagen de referencia** y **Imagen de origen**.

La imagen de referencia es la que permanece fija; la imagen de origen, por otro lado, se mueve hasta encontrar el mejor ajuste entre ambas, utilizando las funciones de coste descritas anteriormente. Para la mayoría de los experimentos, conviene utilizar una representación de los datos funcionales como imagen de referencia y los datos anatómicos como imagen de origen, ya que generalmente se busca minimizar las modificaciones en los datos funcionales.

Haga doble clic en la imagen de referencia y seleccione ``meansub-08_task-flanker_run-1_bold.nii``. Para la imagen de origen, navegue al directorio ``anat`` y seleccione el archivo ``sub-08_T1w.nii``. Luego, haga clic en el botón verde "Ir". Este paso solo debería tomar unos minutos.

Al finalizar, se generará otra ventana con los resultados del corregistro, con la imagen funcional media a la izquierda y la imagen anatómica a la derecha. Haga clic y arrastre la cruceta en cualquiera de las imágenes para comprobar su correcta alineación. Además de la coincidencia de los contornos de los cerebros, también debe comprobar la alineación de las estructuras internas, como los ventrículos. Recuerde que las intensidades se invertirán: las zonas más oscuras de la imagen anatómica (como los ventrículos) aparecerán más brillantes en la imagen funcional.

.. nota::

  Abra la imagen anatómica rediseñada con el botón "Mostrar imagen" (es decir, cargue la imagen ``rsub-08_T1w.nii``). ¿Qué observa en la imagen en comparación con la imagen anatómica original? (Sugerencia: Compare los valores en los campos "Dimensiones" y "Tamaño de Vox").

.. figure:: 03_Coregistration_Check.png


--------------

Ceremonias
*********

1. Al igual que con el paso de realineación <01_SPM_Realign_Unwarp>, podemos optar por que el paso de corregistro sea más rápido, pero de menor calidad, o más lento, pero de mayor calidad. Utilice el campo "Interpolación" para examinar las diferencias entre las distintas opciones disponibles y configúrelo como "Vecino más cercano". Cambie el prefijo del nombre de archivo a "NN" y ejecute el corregistro. ¿Qué observa en el resultado? ¿Cómo se compara con la interpolación predeterminada de "4th Degree B-Spline"? A continuación, compruebe cómo cambia el resultado al usar la opción "7th Degree B-Spline". Tome capturas de pantalla de los resultados de NN, B-Spline de 4.º grado y B-Spline de 7.º grado, y etiquételas claramente.

2. Intente intercambiar las imágenes de referencia y fuente; es decir, convierta la imagen anatómica en la de referencia y la imagen funcional en la fuente. (Recuerde cambiar el prefijo del nombre de archivo a uno que le resulte comprensible para mantener los resultados organizados). ¿Cómo han cambiado las dimensiones y la resolución de los datos funcionales? Teniendo en cuenta que tenemos un total de 292 volúmenes funcionales en comparación con un volumen anatómico, y sabiendo que un conjunto de datos de mayor resolución ocupa más espacio en el ordenador, ¿qué razones se podrían dar para mantener la imagen anatómica como fuente y los datos funcionales como referencia?

Próximos pasos
*********

Ahora que hemos corregistrado las imágenes, estamos listos para normalizar todos nuestros datos a un espacio estandarizado. Sin embargo, antes de hacerlo, necesitamos **segmentar** la imagen anatómica para alinear con mayor precisión los diferentes tipos de tejido al normalizarla.

   

