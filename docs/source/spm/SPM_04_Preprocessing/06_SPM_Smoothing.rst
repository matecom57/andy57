

.. _06_SPM_Suavizado:

====================
Capítulo 6: Suavizado
====================


------

¿Por qué Smooth?
***********

Es común suavizar los datos funcionales o reemplazar la señal de cada vóxel con un promedio ponderado de sus vecinos. Esto puede parecer extraño al principio: ¿por qué querríamos que las imágenes fueran más borrosas de lo que ya son?

Es cierto que el suavizado disminuye la resolución espacial de los datos funcionales y, en general, no buscamos una menor resolución. Sin embargo, el suavizado también ofrece ventajas que pueden compensar las desventajas. Por ejemplo, sabemos que los datos de fMRI contienen mucho ruido, y que este suele ser mayor que la señal. Al promediar sobre vóxeles cercanos, podemos cancelar el ruido y mejorar la señal.


.. figure:: 05_06_Demo_de_suavizado.gif

  En esta animación, se aplican dos núcleos de suavizado diferentes (4 mm y 10 mm) a una resonancia magnética funcional. Observe que, al usar núcleos de suavizado más grandes, las imágenes se vuelven más borrosas y los detalles anatómicos se vuelven menos nítidos. También tenga en cuenta que, para simplificar, esta animación utiliza un corte 2D del cerebro para mostrar este paso de preprocesamiento. En datos reales de resonancia magnética funcional, el núcleo se aplicaría en las tres dimensiones.
  
  
Cómo suavizar en SPM
********************

En la interfaz gráfica de usuario de SPM, haga clic en el botón "Suavizar" y haga doble clic en "Imágenes a suavizar". Seleccione las imágenes funcionales deformadas y expándalas para incluir los 146 fotogramas de cada ejecución. (Consulte los capítulos anteriores para ver ejemplos sobre cómo usar los campos Filtro y Fotogramas para seleccionar las imágenes deseadas). Deje los demás valores predeterminados como están y haga clic en el botón verde "Ir".

.. nota::

  El FWHM predeterminado de 8x8x8 mm probablemente sea demasiado grande para la mayoría de los estudios; puede ayudar a amplificar la señal en regiones corticales más extensas, pero es probable que diluya la señal en regiones funcionalmente más pequeñas, pero más homogéneas. Una vez finalizada esta serie, le recomendamos probar diferentes kernels de suavizado para ver cómo afectan la extensión y la significancia de sus resultados.
  
  
Comprobación de las imágenes suavizadas
****************************

Como antes, usa el botón "Check Reg" para cargar un volumen representativo de la salida que acabas de crear y compáralo con una imagen funcional deformada sin suavizar. ¿Parece que la imagen se ha suavizado al nivel deseado?

.. figure:: 05_06_Salida_suavizada.png


---------------

Ceremonias
*********

1. Intente suavizar los núcleos de estos diferentes tamaños (para ahorrar tiempo, seleccione solo un volumen de sus datos funcionales preprocesados):

* 0 0 0
* 3 3 3
* 30 30 30

Nuevamente, asegúrese de darle a cada uno un prefijo de nombre de archivo distinto.

Antes de ver el resultado, prediga cómo se verá. ¿Coincide el resultado con sus predicciones? Incluya una captura de pantalla del resultado de cada kernel de suavizado.

2. Intente suavizar solo en una dirección, por ejemplo, suministrando un triplete de ``[0 0 10]``, que suavizará 10 mm en la dirección z. ¿Qué observa sobre los resultados?

3. Ciertos tipos de análisis, como el MVPA, requieren que las series temporales de cada vóxel sean lo más distintas posible para clasificar con precisión un vóxel como perteneciente a una u otra condición. ¿Predeciría que el suavizado: (a) se incluiría en el proceso de preprocesamiento con el mismo núcleo de suavizado que un estudio fMRI típico; (b) no se incluiría en el proceso de preprocesamiento; (c) se incluiría con un núcleo de suavizado reducido en comparación con los estudios fMRI típicos; o (d) se incluiría con un núcleo de suavizado aumentado en comparación con los estudios fMRI típicos? Justifique su respuesta.

4. Los datos de fMRI sin procesar ya presentan cierta suavidad inherente, incluso antes de realizar cualquier preprocesamiento. Describa con sus propias palabras qué es esto y por qué lo observaría en los datos de fMRI. (Pista: Si conoce la serie temporal de un vóxel, ¿podría hacer una estimación fundamentada de cómo se ve la serie temporal en los vóxeles vecinos?). Este tema será importante cuando analicemos la corrección de cúmulos, que se abordará en capítulos posteriores.

5. El kernel de suavizado que aplicamos aquí añadirá ese tamaño de suavizado a la suavidad inherente ya presente en los datos. Por ejemplo, si la suavidad inherente es de 3 mm y usamos un kernel de 8 mm, la suavidad resultante tras el preprocesamiento será de aproximadamente 11 mm. Observe el comando AFNI `3dBlurToFMWH`.`__, incluso si no tiene AFNI instalado. Lea la descripción y las recomendaciones. ¿Preferiría usar este comando? ¿Por qué sí o por qué no? Como recordatorio, algunos investigadores prefieren integrar comandos de varios paquetes de software, según sus necesidades; no hay nada inválido en sustituir el comando de un paquete por el de otro y luego ejecutar el resto del proceso como de costumbre.

   

