

.. _Corrección_de_tiempo_de_corte.rst

Capítulo 4: Corrección de la sincronización de segmentos
^^^^^^^^^^

A diferencia de una fotografía, donde la imagen completa se toma en un solo instante, el volumen de fMRI se adquiere en **cortes**. Cada uno de estos cortes tarda en adquirirse, desde decenas hasta cientos de milisegundos.

Los dos métodos más comunes para crear volúmenes son la adquisición secuencial y la intercalada de cortes. La adquisición secuencial de cortes adquiere cada corte adyacente consecutivamente, ya sea de abajo a arriba o de arriba a abajo. La adquisición intercalada de cortes adquiere cada corte de por medio y luego rellena los espacios vacíos en la segunda pasada. Ambos métodos se ilustran en el video a continuación.

.. figura:: SliceTimingCorrection_Demo.gif

Como verá más adelante, al modelar los datos en cada vóxel, asumimos que todos los cortes se adquirieron simultáneamente. Para que esta suposición sea válida, la serie temporal`Para cada segmento, es necesario retroceder en el tiempo el tiempo que llevó obtenerlo. `Sladky et al. (2011) 
    `__ también demostró que la corrección del tiempo de corte puede conducir a aumentos significativos en el poder estadístico para estudios con TR más largos (por ejemplo, 2 s o más), y especialmente en las regiones dorsales del cerebro.



Aunque la corrección del tiempo de corte parece razonable, existen algunas objeciones:

1. En general, es mejor no interpolar (es decir, editar) los datos a menos que sea necesario;

2. Para TR cortos (por ejemplo, alrededor de 1 segundo o menos), la corrección del tiempo de corte no parece conducir a ninguna ganancia significativa en potencia estadística; y

3. Muchos de los problemas abordados mediante la corrección del tiempo de corte se pueden resolver utilizando una **derivada temporal** en el modelo estadístico (que se analiza más adelante en el capítulo sobre ajuste de modelos).

La configuración predeterminada de FSL es no aplicar corrección temporal de cortes e incluir, en su lugar, una derivada temporal. Más adelante, realizará un ejercicio comparando los datos con y sin corrección temporal de cortes para observar la magnitud de la diferencia.

.. figura::Prestats_STC.png
  :escala: 60 %
  

El último paso de preprocesamiento que abordaremos en la pestaña Preestadísticas es el Suavizado. Para saber qué es el suavizado y cómo usarlo, haga clic en el botón Siguiente.

    
   

