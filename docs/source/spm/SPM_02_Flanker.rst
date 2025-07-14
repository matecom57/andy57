

.. _SPM_02_Flanquero:

=================================
Tutorial de SPM n.º 2: La tarea de flanqueo
=================================

------------------

El conjunto de datos que descargaste utiliza la tarea Flanker, diseñada para aprovechar un proceso mental conocido como control cognitivo. En este curso, definiremos el control cognitivo como la capacidad de ignorar estímulos irrelevantes para realizar una tarea correctamente.

En la tarea Flanker, las flechas apuntan a la izquierda o a la derecha, y se le indica al sujeto que presione uno de los dos botones que indican la dirección de la flecha central. Si apunta a la izquierda, el sujeto presiona el botón "izquierda"; si apunta a la derecha, el botón "derecha". La flecha central está flanqueada por otras flechas que apuntan en la misma dirección o en la dirección opuesta.

.. figure:: 02_Flanker_Example.png

	Un ejemplo de las dos condiciones de la tarea Flanqueador. En la condición Incongruente, la flecha central (en la que se centra el sujeto) apunta en dirección opuesta a las flechas flanqueantes; en la condición Congruente, la flecha central apunta en la misma dirección que las flechas flanqueantes. En este ejemplo, la respuesta correcta en la condición Incongruente sería pulsar el botón "izquierda", y la respuesta correcta en la condición Congruente sería pulsar el botón "derecha". Para realizar una versión de la tarea Flanqueador, haga clic aquí.`__.

Como puede imaginar, la tarea es más fácil si la flecha central apunta en la misma dirección que la flecha lateral, y más difícil si apunta en la dirección opuesta. Llamaremos a la primera condición "Congruente" y a la segunda "Incongruente". Los sujetos suelen ser más lentos y menos precisos en la condición Incongruente, y más rápidos y precisos en la condición Congruente. Dado que la diferencia en los tiempos de reacción es robusta y fiable, en nuestros datos de fMRI deberíamos observar una diferencia notable en la señal :ref:`BOLD.
    " también.

.. figure:: 02_Flanker_Design.png

Ilustración de la tarea de Flanker para este estudio, adaptada de Kelly et al. (2008). Se muestra al sujeto una cruz de fijación para que enfoque el centro de la pantalla, y luego se presenta una prueba de Flanker congruente o incongruente durante 2000 ms. Durante la prueba, el sujeto presiona el botón izquierdo o derecho. A continuación, se produce un intervalo de fluctuación que dura entre 8000 ms y 14 000 ms. (Tenga en cuenta que los intervalos de fluctuación suelen aumentar en segundos; en este caso, la fluctuación para una prueba dada sería una selección aleatoria de uno de los siguientes: 8000 ms, 9000 ms, 10 000 ms, 11 000 ms, 12 000 ms, 13 000 ms y 14 000 ms). Se presenta otra cruz de fijación para comenzar la siguiente prueba.

Nuestro objetivo es estimar la magnitud de la señal BOLD para cada condición y luego **contrastar** (es decir, tomar la diferencia de) las dos condiciones para ver si son significativamente diferentes entre sí.

.. nota::
	Esta descripción de la tarea plantea un punto importante sobre las buenas prácticas para diseñar estudios de fMRI: si puede diseñar una tarea conductual que produzca un efecto fuerte y confiable, aumentará sus probabilidades de encontrar un efecto en sus datos de imágenes. Los datos de fMRI son notoriamente ruidosos: si no ve un efecto conductual en su estudio, lo más probable es que tampoco encuentre un efecto en sus datos de imágenes.

Video
*****

Para ver una descripción general en video de la tarea Flanker, haga clic aquí
     `__. (El título del video dice "Tutorial AFNI n.° 2", pero los principios de la tarea Flanker son los mismos sin importar el paquete que uses).

     
    
   

