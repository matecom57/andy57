

.. _Suavizado.primero:
  
Capítulo 5: Suavizado
=============

------

¿Por qué Smooth?
-----------

Es común suavizar los datos funcionales o reemplazar la señal de cada vóxel con un promedio ponderado de sus vecinos. Esto puede parecer extraño al principio: ¿por qué querríamos que las imágenes fueran más borrosas de lo que ya son?

Es cierto que el suavizado disminuye la resolución espacial de los datos funcionales, y no buscamos una menor resolución. Sin embargo, el suavizado también ofrece ventajas que pueden compensar las desventajas. Por ejemplo, sabemos que los datos de fMRI contienen mucho ruido, y que este suele ser mayor que la señal. Al promediar sobre vóxeles cercanos, podemos cancelar el ruido y mejorar la señal.


.. figura:: Smoothing_Demo.gif

  En esta animación, se aplican dos núcleos de suavizado diferentes (4 mm y 10 mm) a una resonancia magnética funcional. Observe que, al usar núcleos de suavizado más grandes, las imágenes se vuelven más borrosas y los detalles anatómicos se vuelven menos nítidos. También tenga en cuenta que, para simplificar, esta animación utiliza un corte 2D del cerebro para mostrar este paso de preprocesamiento. En datos reales de resonancia magnética funcional, el núcleo se aplicaría en las tres dimensiones.

.. (¿Habla aquí de un ejemplo de cómo funciona el promedio para dar lugar a una señal verdadera? Estoy pensando en el ejemplo en el que se les pregunta a diez estudiantes la población de la ciudad en la que están; ninguna estimación individual es correcta, pero si se promedia en conjunto, está bastante cerca de la población real).

El suavizado ofrece otra ventaja. Como verá en el siguiente capítulo, nuestro objetivo es **normalizar** el cerebro de cada sujeto a un cerebro modelo con coordenadas estandarizadas. Haga clic en el botón Siguiente para obtener más información sobre la normalización y cómo el suavizado puede ayudar a mejorar la potencia estadística.



