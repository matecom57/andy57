

.._Normalización_del_Registro:

Capítulo 6: Registro y normalización
^^^^^^^^^^

--------

Descripción general
***************

Aunque el cerebro de la mayoría de las personas es similar (por ejemplo, todos tenemos una circunvolución cingulada y un cuerpo calloso), también existen diferencias en el tamaño y la forma cerebrales. Por lo tanto, si queremos realizar un análisis grupal, debemos asegurarnos de que cada vóxel de cada sujeto corresponda a la misma parte del cerebro. Si medimos un vóxel en la corteza visual, por ejemplo, debemos asegurarnos de que la corteza visual de cada sujeto esté alineada.

Esto se hace **Registrando** y **Normalizando** las imágenes. Tal como doblarías la ropa para que quepa dentro de una maleta, cada cerebro necesita ser transformado para tener el mismo tamaño, forma y dimensiones. Hacemos esto normalizando (o **deformando**) a una **plantilla**. Una plantilla es un cerebro que tiene dimensiones y coordenadas estándar; estándar, porque la mayoría de los investigadores han acordado usarlas al informar sus resultados. De esa manera, si normalizas tus datos a esa plantilla y encuentras un efecto en las coordenadas X=3, Y=20, Z=42, alguien más que haya deformado sus datos a la misma plantilla puede comparar sus resultados con los tuyos. Las dimensiones y coordenadas del cerebro plantilla también se conocen como **espacio estandarizado**.

.. figura:: MNI_Template.png

  Un ejemplo de una plantilla de uso común, el cerebro :ref:`MNI152`. Este es un promedio de 152 cerebros adultos sanos, que representan la población de la que se extraen la mayoría de los estudios. Si está estudiando otra población, como niños o ancianos, por ejemplo, considere usar una plantilla creada con representantes de esa población. (Pregunta: ¿Por qué está borrosa esta plantilla? Revise el capítulo anterior sobre suavizado para obtener una pista).
  
  
Transformaciones afines
****************

Para deformar las imágenes según una plantilla, usaremos una **transformación afín**. Esta es similar a la transformación de cuerpo rígido descrita anteriormente en Corrección de movimiento, pero añade dos transformaciones más: **zooms** y **cortes**. Mientras que las traslaciones y rotaciones son fáciles de realizar con un objeto cotidiano como un bolígrafo, los zooms y los cortes son más inusuales: los zooms reducen o amplían la imagen, mientras que los cortes toman las esquinas diagonalmente opuestas de la imagen y las estiran. La animación a continuación resume estos cuatro tipos de **transformaciones lineales**.

.. figura:: AffineTransformations.gif

.. nota:: Al igual que con las transformaciones de cuerpo rígido, los zooms y los cortes tienen tres grados de libertad: puede hacer zoom o cortar una imagen a lo largo del eje x, y o z. En total, entonces, las transformaciones afines tienen doce grados de libertad. Estas también se llaman transformaciones lineales porque una transformación aplicada en una dirección a lo largo de un eje está acompañada por una transformación de igual magnitud en la dirección opuesta. Una traslación de un milímetro *a* la izquierda, por ejemplo, implica que la imagen se ha movido un milímetro *desde* la derecha. Del mismo modo, si una imagen se amplía un milímetro a lo largo del eje z, se amplía un milímetro en ambas direcciones a lo largo de ese eje. Las transformaciones sin estas restricciones se llaman **transformaciones no lineales**. Por ejemplo, una transformación no lineal puede ampliar la imagen en una dirección mientras la encoge en la otra dirección, como cuando se aprieta una esponja. Estos tipos de transformaciones se tratarán más adelante.

Registro y Normalización
***************

Recuerde que nuestro conjunto de datos incluye imágenes anatómicas y funcionales. Nuestro objetivo es adaptar las imágenes funcionales a la plantilla para realizar un análisis grupal de todos los sujetos. Si bien parece razonable adaptar las imágenes funcionales directamente a la plantilla, en la práctica esto no funciona bien: las imágenes tienen baja resolución y, por lo tanto, es menos probable que coincidan con los detalles anatómicos de la plantilla. La imagen anatómica es una mejor opción.

Aunque esto parezca no ayudarnos a alcanzar nuestro objetivo, de hecho, deformar la imagen anatómica puede ayudar a estandarizar las imágenes funcionales. Recuerde que las exploraciones anatómicas y funcionales suelen adquirirse en la misma sesión, y que la cabeza del sujeto se mueve poco o nada entre las exploraciones. Si ya hemos normalizado nuestra imagen anatómica a una plantilla y registrado las transformaciones realizadas, podemos aplicar las mismas transformaciones a las imágenes funcionales, siempre que comiencen en el mismo lugar que la imagen anatómica.

Esta alineación entre las imágenes funcionales y anatómicas se denomina **Registro**. La mayoría de los algoritmos de registro utilizan los siguientes pasos:

1. Suponga que las imágenes funcionales y anatómicas están prácticamente en la misma ubicación. De no ser así, alinee los contornos de las imágenes.

2. Aproveche que las imágenes anatómicas y funcionales tienen diferentes ponderaciones de contraste; es decir, las áreas oscuras en la imagen anatómica (como el líquido cefalorraquídeo) aparecerán brillantes en la imagen funcional, y viceversa. Esto se denomina **información mutua**. El algoritmo de registro desplaza las imágenes para probar diferentes superposiciones de las imágenes anatómicas y funcionales, haciendo coincidir los vóxeles brillantes de una imagen con los oscuros de otra, y los oscuros con los brillantes, hasta encontrar una coincidencia irreprochable.

3. Una vez que se encuentra la mejor coincidencia, se aplican a las imágenes funcionales las mismas transformaciones que se utilizaron para deformar la imagen anatómica a la plantilla.


.. figura:: Registro_Normalización_Demo.gif


Normalización, suavizado y potencia estadística
*******

Como leíste en la página anterior
    `__, el suavizado tiende a cancelar el ruido y mejorar la señal. Esto también aplica a los análisis de grupo, en los que todas las imágenes de los sujetos se han normalizado según una plantilla. Si bien las imágenes funcionales de cada sujeto se transformarán para que coincidan con la forma general y las características anatómicas generales de la plantilla, habrá variaciones en la alineación de las regiones anatómicas más pequeñas entre las imágenes funcionales normalizadas. Si las imágenes se suavizan, habrá mayor solapamiento entre los grupos de señal y, por lo tanto, mayor probabilidad de detectar un efecto significativo.

-----

La pestaña de registro
*******

El registro y la normalización, aunque son distintos, se integran en un solo paso en la pestaña "Registro" de la interfaz gráfica de usuario de FEAT. Una vez seleccionada esta pestaña, haga clic en el botón junto a "Imagen estructural principal" para expandir el campo de entrada. A continuación, seleccione la imagen del cráneo del sujeto sin hueso; en este caso, la que creamos con un umbral de intensidad fraccionaria de 0,2.

Observará que hay menús desplegables debajo de los campos "Imagen estructural principal" y "Espacio estándar". Los menús del campo "Imagen estructural principal" corresponden a las opciones para registrar la imagen funcional con la anatómica. Los menús del campo "Espacio estándar" son opciones para normalizar la imagen anatómica con respecto a la imagen de plantilla. Dentro de estos conjuntos de menús, el menú desplegable de la izquierda corresponde a la ventana "Buscar" y el de la derecha a la ventana "Grados de libertad".

En la ventana "Buscar", hay tres opciones: 1) Sin búsqueda; 2) Búsqueda normal; y 3) Búsqueda completa. Esto le indica a FSL el grado de búsqueda necesario para lograr una buena alineación inicial entre las imágenes funcionales y anatómicas (para el registro) y entre las imágenes anatómicas y las plantillas (para la normalización). La opción "Búsqueda completa" es más larga, pero más exhaustiva y, por lo tanto, más propensa a producir un mejor registro y normalización.

En la ventana "Grados de libertad", puede usar 3, 6 o 12 grados de libertad para transformar las imágenes. El registro cuenta con una opción adicional, "BBR", que significa Registro de Límites Cerebrales. Esta técnica de registro más avanzada utiliza los límites tisulares para ajustar la alineación entre las imágenes funcionales y anatómicas. Al igual que la opción de búsqueda completa mencionada anteriormente, esta opción tarda más, pero suele ofrecer una mejor alineación.

Por ahora, configure las opciones de búsqueda en Búsqueda completa y los grados de libertad en 12 grados de libertad. Si ya ha cargado sus imágenes funcionales en la pestaña Datos, haga clic en el botón Ir para ejecutar todos los pasos de preprocesamiento.

.. figura:: Registration_Setup.gif



Video
********

El registro y la normalización son el último paso del proceso de preprocesamiento para un solo sujeto. Para ver un video de captura de pantalla que muestra cómo configurar todo el preprocesamiento a través de la interfaz gráfica de FEAT, haga clic aquí.
     `__.

     
    
   

