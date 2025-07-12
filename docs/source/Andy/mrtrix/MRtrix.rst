Introducción a MRtrix
=====================

https://andysbrainbook-readthedocs-io.translate.goog/en/latest/MRtrix/MRtrix_Introduction.html?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=tc


**¿Qué es MRtrix?**

MRtrix es un paquete de software para analizar datos de difusión. Una de las ventajas notables de MRtrix sobre las técnicas de ajuste de tensores es su método de deconvolución esférica restringida (CSD); este método deconvoluciona la señal de difusión en cada vóxel en una serie de haces de fibras superpuestos. Esto reduce el problema del cruce de fibras, que puede ser un factor de confusión al ajustar un tensor.

Además de una biblioteca de comandos creada por el equipo de MRtrix, el software también incluye contenedores para los comandos utilizados con FSL: en particular, los comandos topupy eddy. Si aún no lo ha hecho, descargue e instale el paquete de software fMRI FSL .

**Nota**

Este curso se basa en los pasos descritos en la documentación de MRtrix , especialmente en los capítulos "Preprocesamiento DWI" y "Deconvolución esférica restringida". Varios de los pasos y explicaciones se derivan del excelente tutorial de BATMAN de Marlene Tahedl , y en muchos lugares utilizo su notación de archivos. También quiero agradecer a John Plass, del laboratorio David Brang de la Universidad de Michigan, por compartir sus scripts conmigo y responder a mis preguntas.

**Objetivos de este curso**

Este curso te enseñará los fundamentos de la difusión: cómo se recopila y cómo se analiza. Aprenderás a realizar análisis basados ​​en fixels para cuantificar la densidad de fibras de materia blanca dentro de cada vóxel y a crear tractogramas mediante tractografía probabilística. Finalmente, aprenderás a crear conectomas y a visualizar la cantidad de fibras que conectan distintas regiones cerebrales.

**Pasos de preprocesamiento**

    * Introducción a MRtrix: descripción general de las imágenes de difusión
    * Tutorial n.° 1 de MRtrix: Descargar e instalar
    * Tutorial n.º 2 de MRtrix: Cómo descargar el conjunto de datos
    * Tutorial n.º 3 de MRtrix: Análisis de los datos
    * Tutorial n.° 4 de MRtrix: Preprocesamiento
    * Tutorial n.º 5 de MRtrix: Deconvolución esférica restringida
    * Tutorial n.° 6 de MRtrix: Creación de los límites del tejido
    * Tutorial n.° 7 de MRtrix: Líneas de corriente
    * Tutorial n.° 8 de MRtrix: Creación y visualización del conectoma
    * Tutorial n.° 9 de MRtrix: Creación de scripts
    * Tutorial n.° 10 de MRtrix: Análisis a nivel de grupo
    * Tutorial n.° 11 de MRtrix: Análisis basado en Fixel


Introducción a MRtrix: descripción general de las imágenes de difusión
-----------------------------------------------------------------------

**Descripción general**

Hasta ahora, este libro ha abordado la técnica de resonancia magnética más popular: la resonancia magnética funcional o fMRI. Estas imágenes funcionales, que miden la señal generada por los cambios en el flujo sanguíneo, suelen ir acompañadas de imágenes estructurales que se adquieren mediante el mismo método básico: los diferentes tipos de tejido cerebral tienen diferentes tasas de relajación T1 y T2 , que se utilizan para crear imágenes con contraste entre los tejidos. En las exploraciones T1 o anatómicas, la sustancia blanca es más clara que la sustancia gris, que a su vez es más clara que el líquido cefalorraquídeo; en las exploraciones T2 o funcionales, las intensidades relativas se invierten.
../../_images/00_T1_T2_Intensidades.png

Imágenes típicas ponderadas en T1 (anatómicas) y T2 (funcionales). Observe cómo se invierten las intensidades relativas de los tipos de tejido al pasar de la ponderación en T1 a la ponderación en T2.

Sin embargo, existen otros tipos de imágenes que pueden adquirirse con un escáner de resonancia magnética. En este módulo, nos centraremos en la resonancia magnética ponderada por difusión (RMD), que mide la difusividad relativa en diferentes partes del cerebro, en particular, en los tractos de sustancia blanca.

**La estructura de la sustancia blanca**

¿Por qué la dMRI se centra en los tractos de sustancia blanca? Imagine desmenuzar un palito de queso y luego desmenuzar el cerebro: al igual que el queso, el cerebro tiene direcciones lacrimales preferidas. Estas direcciones corresponden a los tractos de sustancia blanca subyacentes, que son haces densos de neuronas mielinizadas que conectan partes cercanas y distantes del cerebro. Por ejemplo, el fascículo longitudinal inferior conecta las regiones visual y temporal del cerebro, mientras que el fascículo uncinado conecta las regiones temporal y frontal inferior del cerebro. Estos tractos recorren las tres dimensiones del cerebro y pueden discurrir paralelos o cruzarse.
../../_images/00_Tract_Examples.png

Ilustración de varios tractos principales de sustancia blanca. Figura tomada de Thiebaut et al., 2015.

La sustancia blanca del cerebro recibe su nombre de su color; estas neuronas están altamente mielinizadas, lo que significa que poseen una gruesa capa lipídica que las aísla y facilita la transmisión de impulsos eléctricos, como un cable eléctrico aislado. Las neuronas de la sustancia gris, en cambio, son relativamente amielínicas, lo que permite una mayor densidad neuronal en una zona determinada.

**Historia de la difusión**

Si bien la composición del tejido cerebral se conoce desde hace tiempo, la obtención de imágenes de la difusión de los tractos de sustancia blanca es una técnica nueva. Para comprender cómo se aprovecharon las propiedades de la sustancia blanca con este fin, revisaremos brevemente la historia de la difusión y cómo los científicos aplicaron este concepto a la obtención de imágenes cerebrales.

**Movimiento browniano**

La primera descripción formal de la difusión la realizó Robert Brown, botánico escocés, en 1827. Al observar partículas microscópicas a través de un microscopio, observó que estas parecían moverse aleatoriamente, de forma similar a cómo las motas de polvo, al observarlas moverse a través de un haz de luz, parecen moverse siguiendo patrones aleatorios. Browning concluyó que el movimiento se debía a la colisión de partículas más pequeñas con las moléculas más grandes observadas a través del microscopio. Por ejemplo, al verter un tinte en agua, el movimiento aleatorio de las moléculas de agua hace que el tinte se disperse aleatoriamente hasta que el agua del recipiente alcanza un tono uniforme. Un ejemplo más común y cotidiano se puede observar al verter leche en el café: observe cómo la leche se arremolina y se mezcla con su entorno, y tendrá una excelente demostración del movimiento browniano.

Las propiedades del medio determinan la velocidad del movimiento browniano. Por ejemplo, aumentar la temperatura del agua circundante acelerará el movimiento de las moléculas de agua y, en consecuencia, el de las partículas. Si la viscosidad del medio es mayor (por ejemplo, si vertemos colorante alimentario en un recipiente con miel), las moléculas se mueven más lentamente, y las partículas del colorante también. Por otro lado, disminuir la temperatura y la viscosidad tendrá el efecto contrario.

Por último, y más relevante para nuestros futuros tutoriales sobre imágenes de difusión, el movimiento browniano de las partículas y las moléculas está determinado por el tamaño y la forma del recipiente. El colorante alimentario vertido en un recipiente esférico con agua se difundirá aleatoriamente en todas direcciones. Por otro lado, el colorante alimentario vertido en un vaso de precipitados cilíndrico se difundirá rápidamente a lo largo del vaso; las partículas pronto chocarán con las paredes del recipiente y se verán obligadas a moverse hacia arriba o hacia abajo. A este tipo de recipiente lo llamamos anisotrópico , lo que significa que las dimensiones del recipiente hacen que las partículas se difundan a lo largo de un eje predominante. (Si tiene experiencia con fMRI, piense en los vóxeles anisotrópicos, que tienen una dimensión más larga que las demás).

**Nota**

Para ver un vídeo del movimiento browniano, haga clic aquí .

Albert Einstein combinó todos estos factores (temperatura, tamaño de partícula y viscosidad) en una única ecuación conocida como ecuación de Stokes-Einstein :
../../_images/00_Ecuación_de_Stokes_Einstein.png

El coeficiente de difusión, D , aumenta con el aumento de la temperatura ( T ) y disminuye con una mayor viscosidad (simbolizada por eta) y un mayor radio de partícula ( r ). k representa la constante de Boltzmann. Este coeficiente de difusión influirá en la adquisición de imágenes ponderadas por difusión , tema que abordaremos a continuación.

**Difusión y resonancia magnética**

A principios de la década de 1990, una nueva técnica de adquisición de imágenes, denominada imágenes ecoplanares (EPI), permitió a los investigadores obtener imágenes funcionales del cerebro con mucha mayor rapidez. Simultáneamente, científicos como Michael Moseley y Steven Warach comenzaron a explorar otras maneras de aprovechar las propiedades de las moléculas de agua para generar diferentes tipos de mapas de contraste. Descubrieron que, así como las propiedades T1 y T2 de los tejidos cerebrales podían utilizarse para crear diferencias de intensidad en las imágenes adquiridas, la difusión del agua también podía generar diferencias en la magnitud de la señal.

Quizás recuerde de un curso introductorio de física de resonancia magnética que las imágenes ponderadas en T1 se utilizan a menudo para exploraciones anatómicas, y que las imágenes ponderadas en T2 suelen utilizarse para exploraciones funcionales. En las imágenes ponderadas en T2, la presencia o ausencia de hemoglobina oxigenada cercana provoca un aumento o disminución de la señal emitida por los protones de hidrógeno de las moléculas de agua en el cerebro. En este caso, se activa un pulso de radiofrecuencia para inclinar el espín de los átomos de hidrógeno y se desactiva rápidamente; la señal es entonces emitida por los protones de hidrógeno y detectada por un sensor dentro del imán, y el proceso se repite hasta que se genera una serie temporal completa de datos funcionales.

¿Qué pasaría si, en cambio, cambiáramos la intensidad del campo magnético en diferentes ejes del cerebro? Recuerde que, si bien las exploraciones ponderadas en T2 se utilizan principalmente para la obtención de imágenes funcionales, también pueden utilizarse para crear imágenes anatómicas. En este caso, el líquido cefalorraquídeo y la materia gris aparecerían más claros, mientras que la materia blanca aparecería más oscura. Si aplicáramos un gradiente magnético al escanear el cerebro, podríamos intensificar el campo magnético en una dirección y debilitarlo en la opuesta. Por ejemplo, supongamos que el campo magnético se debilita ligeramente en el lado izquierdo del cerebro y se intensifica ligeramente en el lado derecho, aumentando gradualmente su intensidad a medida que nos movemos de izquierda a derecha. Dado que la frecuencia de los espines de los átomos de hidrógeno es proporcional a la intensidad del campo magnético, esperaríamos que los espines del lado izquierdo del cerebro fueran ligeramente más lentos que los del lado derecho.

En este punto, los espines estarían desfasados ​​entre sí; es decir, precesarían a diferentes velocidades según la parte del campo magnético en la que se encuentren. Dado que los protones están ahora desfasados, el gradiente que acabamos de aplicar se denomina gradiente de desfase . Si aplicáramos un gradiente de refase igual y opuesto (es decir, el campo magnético sería más intenso a la izquierda y más débil a la derecha), los espines de los átomos se realinearían. La siguiente figura resume este proceso de gradientes de desfase y refase:
../../_images/00_Desfase_Refase_Gradientes.png

Figura de Mori, 2007. Los círculos rojo, verde y azul representan átomos de hidrógeno, y las flechas dentro de los círculos representan la dirección de los espines; imagine que todos se mueven en la misma dirección alrededor de la circunferencia del círculo y a la misma velocidad. Un gradiente de desfase (fila central) es ligeramente más débil a la izquierda y ligeramente más fuerte a la derecha; como resultado, al desactivar el gradiente, los átomos giran desfasados ​​entre sí. Un gradiente de refase aplica entonces un gradiente igual y opuesto, y al final los átomos giran en la misma dirección y a la misma velocidad.

**Aparte: Creación del gradiente de difusión y los valores B**

Los gradientes de difusión mencionados anteriormente se generan mediante los siguientes parámetros:

    * La magnitud del gradiente de difusión (G);

    * El tiempo entre gradientes (𝚫); y

    * T duración del gradiente de difusión (𝜹).

Estos pueden combinarse en una ecuación para el denominado valor b , que se muestra en la figura siguiente. Tenga en cuenta que el valor b es proporcional a la magnitud del gradiente, su duración y el tiempo entre gradientes; si alguno de estos parámetros aumenta, el valor b también aumenta. Por ahora, tenga presente esta ecuación; la abordaremos más adelante cuando analicemos cómo los valores b afectan el contraste de las imágenes ponderadas por difusión.
../../_images/00_BValue.png

**Revisando los gradientes: efectos de la difusión**

En el ejemplo anterior, asumimos que un gradiente de refase reorganizaría los átomos de hidrógeno. Esta suposición es cierta, pero solo si los átomos de hidrógeno no se mueven entre la activación y desactivación de los gradientes de desfase y refase. Si, por el contrario, se mueven —es decir, si se difunden, según los principios del movimiento browniano que analizamos anteriormente—, el gradiente de refase no provocará una realineación de los átomos de hidrógeno. Más bien, su desalineación será proporcional a su grado de difusión entre los gradientes.
../../_images/00_Gradientes_Difusión.png

Figura de Mori, 2007. El período entre los gradientes, al que nos referiremos como fase de mezcla , permite que los átomos de hidrógeno de diferentes ubicaciones se mezclen. Esto depende de factores como la temperatura ambiente y la restricción del entorno circundante: los átomos de hidrógeno en un espacio relativamente libre (como los ventrículos) se difunden más que aquellos en un espacio más restringido. Al aplicar el gradiente de refase, los átomos giran desfasados ​​entre sí.

El resultado es una imagen de contraste similar a las imágenes funcionales ponderadas en T2 que quizás haya visto antes: existe contraste entre los principales tipos de tejido, como la sustancia blanca y la sustancia gris. Sin embargo, al observarla más de cerca, observamos que la imagen es más oscura en ciertas zonas; esto se debe a la difusión de las moléculas de agua durante la fase de mezcla. Cuando los átomos están desfasados ​​entre sí, la señal se atenúa. (Imagine un grupo de personas empujando un bloque en la misma dirección. La fuerza que ejercen moverá el bloque en la dirección en la que empujan. Si, en cambio, algunas personas empujan lateralmente y otras en la dirección opuesta, el movimiento del bloque se ralentiza o se detiene por completo). En este caso, una mayor pérdida de señal implica una mayor difusión, siendo la cantidad de pérdida relativa a una exploración adquirida sin aplicar gradientes de difusión; en otras palabras, relativa a una exploración con un valor b de cero.
../../_images/00_Difusión_de_señales.png

La siguiente figura resume lo que hemos analizado hasta ahora. Una imagen ponderada por difusión con un valor b de cero es prácticamente idéntica a una imagen típica ponderada en T2: el LCR es brillante y la materia gris es oscura. A medida que aumentamos los valores b, observamos una mayor pérdida de señal en zonas específicas del cerebro, principalmente en la sustancia blanca. Esto se debe a que el agua dentro de estos tractos de sustancia blanca se difunde principalmente a lo largo de la dirección del tracto, y la imagen generada muestra una señal correspondientemente menor. (Los valores b más altos también hacen que la imagen sea más susceptible a artefactos de imagen, como el movimiento y las corrientes magnéticas llamadas remolinos; los revisaremos en un capítulo posterior sobre preprocesamiento).
../../_images/00_bvalues.png

Los valores b más altos serán más sensibles para detectar la difusión, pero con el riesgo de generar más ruido y mayor susceptibilidad a los artefactos de vibración.

**Nota**

Las imágenes de difusión adquiridas con más de un valor b se denominan adquisiciones multicapa . Esto permite distinguir con mayor precisión la orientación de la difusión, ya que la imagen mostrará diferentes niveles de pérdida de señal en cada valor b, dependiendo de la magnitud de la difusión. Retomaremos este concepto en un capítulo posterior.

**Vectores B**

Hasta ahora, hemos aprendido cómo se aplican los gradientes de difusión y cómo interpretar la señal resultante en la imagen. Para comprender mejor cómo se crean las imágenes de difusión, también necesitamos conocer la dirección de los gradientes aplicados. Estas direcciones se conocen como vectores b , o bvecs . Observará que, una vez descargados los datos de un escaneo ponderado por difusión, tendrá dos archivos de texto: uno suele tener el sufijo .bval , que indica los valores b, y otro con el sufijo .bvec , que representa los vectores b.

Supongamos que recopiló 40 imágenes ponderadas por difusión. Supongamos también que el primer volumen se adquirió con un valor b de cero y el resto con valores b de 1000. El archivo bvals tendría 40 entradas, y cada bval correspondería a un volumen individual en la imagen ponderada por difusión. El archivo bvecs, por otro lado, tendría 40 tripletes de números que indican la dirección del gradiente de difusión para ese volumen en las direcciones x, y y z. Si conocemos tanto la dirección como la magnitud del gradiente, podemos hacer una estimación razonable de la difusión a lo largo de dicho gradiente, en función de los cambios en la señal adquirida de esos vóxeles.
../../_images/00_bvals_bvecs.png

Ejemplo de contenido de los archivos .bvals y .bvecs. La estructura del archivo bvecs es más clara si se importa a una hoja de cálculo; el archivo está formateado para agrupar los números en tripletes. Cada triplete de bvecs corresponde a un único bval.

**Nota**

Un parámetro que puede controlar es el número de direcciones que desea escanear con los gradientes. Por ejemplo, podría adquirir 64 o 128 imágenes, y cada una de ellas tendrá gradientes de difusión aplicados desde una dirección ligeramente diferente. Un mayor número de direcciones resulta en una mayor resolución angular , lo que permite realizar distinciones espaciales más precisas sobre la dirección de la difusión. La desventaja, como con cualquier método que aumente la resolución, es que un mayor número de escaneos requiere más tiempo.

**Juntándolo todo: modelando el tensor**

Esta combinación de bvals y bvecs nos permite construir un tensor y ajustarlo a cada vóxel de nuestra imagen ponderada por difusión. Para este tutorial, considere un tensor como un modelo de fuerzas que ejercen presión a lo largo de las dimensiones x, y y z. El agua que fluye por una manguera de jardín, por ejemplo, ejerce presión contra los límites del tubo, pero fluye principalmente a lo largo de la manguera. Las direcciones de los vectores propios de energía se denominan , y la magnitud de los valores propios de energía .

Aplicados a imágenes ponderadas por difusión, utilizamos estos mismos conceptos para modelar la señal observada en cada vóxel como una combinación de vectores propios y valores propios. Los vectores propios indican la dirección de la difusión y los valores propios representan su magnitud. Para retomar el ejemplo de la manguera de jardín, la fuerza del agua tendría un vector propio y un valor propio elevados a lo largo del tubo; de forma similar, podemos modelar la difusión en cada vóxel del cerebro como una combinación de vectores propios y valores propios. Una vez calculada la combinación de valores que mejor representa la señal observada en el vóxel actual, podemos utilizar diversas ecuaciones para calcular las diferentes propiedades de la difusión en ese vóxel. La ecuación más popular para esta imagen del tensor de difusión se denomina Anisotropía Fraccionaria (FA). Esta se puede calcular mediante la fórmula:
../../_images/00_FA_formula.png

La anisotropía fraccional es la suma ponderada de los valores propios de cada vóxel. Un valor de FA más alto indica una mayor difusión en una de las direcciones, mientras que un valor de FA más bajo indica que la difusión es muy baja o que esta no está restringida y se extiende aleatoriamente en cada dirección (como, por ejemplo, en los ventrículos cerebrales). Si observamos que la difusión es mayor en una de las dimensiones, podemos codificarla por colores según la dirección. En las imágenes de difusión, la convención es representar la difusión en el eje x en rojo, la difusión en el eje y en verde y la difusión en el eje z en azul. La imagen a continuación resume este esquema de codificación por colores.
../../_images/00_Eigenvectors.png

Ajustar un tensor en cada vóxel permite generar diferentes tipos de mapas de difusión, como mapas de anisotropía fraccional. Para crear estos mapas se puede utilizar la estadística espacial basada en tractos (TBSS), un popular paquete de análisis de difusión FSL. De forma similar al análisis de datos de fMRI, estos mapas se pueden combinar en un mapa de análisis de grupos y extraer datos de las regiones de interés dentro del mapa.
../../_images/00_FA_Map.png

Tensores generados por TBSS de FSL. Para obtener una descripción general de cómo analizar un sujeto con este paquete, haga clic aquí .

**Otras medidas de difusión**

Aunque FA es la medida de difusión más popular, hay algunas otras que revisaremos brevemente:

    * Difusividad media (MD): el promedio de los valores propios, calculado sumando los valores propios y dividiéndolos por 3. Es útil para identificar patologías cerebrales como edemas.

    * Difusividad axial (AD): El valor del valor propio más grande.

    * Difusividad Radial (DR): El promedio de los dos valores propios más pequeños. Se utiliza a menudo para analizar haces de fibras grandes orientados en la misma dirección, como el cuerpo calloso.

**Desventajas de las imágenes por tensor de difusión: el problema de las fibras cruzadas**

Aunque la obtención de imágenes con tensor de difusión ha sido uno de los métodos de análisis más populares desde el inicio de la obtención de imágenes ponderadas por difusión, se ha visto obstaculizada por el problema de las fibras cruzadas . El método de ajuste de tensor descrito anteriormente es útil para analizar vóxeles que solo contienen tractos de materia blanca que viajan en una sola dirección. Si, por otro lado, el vóxel contiene fibras que se cruzan entre sí, el método puede conducir a resultados espurios. Para tomar el caso más extremo, imaginemos que hemos adquirido una imagen ponderada por difusión para un solo vóxel, y que este vóxel contiene fibras de materia blanca que se cruzan en ángulos rectos entre sí. Dado que el tensor está restringido a generar una única solución para estimar todos sus vectores y valores propios, no puede estimar la dirección y la magnitud de la difusión para cada haz de fibras por separado. En su lugar, dividirá la diferencia y concluirá que no hay difusión en ninguna dirección; en otras palabras, la difusión de los dos tractos se cancelarán mutuamente.
../../_images/00_CrossingFibers.png

Ilustración de fibras de materia blanca que se cruzan en ángulos rectos. Imagen cortesía de John Plass.

Para abordar este problema, se desarrolló una técnica conocida como Deconvolución Esférica . En lugar de buscar una única solución para una señal compleja medida en cada vóxel, la deconvolución esférica asume que la señal de difusión es un promedio de la señal esperada de múltiples fibras individuales que se cruzan en diferentes ángulos. Por lo tanto, se utiliza una sola fibra como función base para deconvolucionar la señal más compleja.
../../_images/00_FunciónBase.png

Para comprender esto mejor, revisemos cómo se utilizan las funciones base con datos de fMRI. Quizás recuerden de otra parte del libro que la señal BOLD que adquirimos de un solo vóxel puede modelarse como un promedio de varias respuestas BOLD superpuestas a eventos que ocurren con poca frecuencia. Para estimar la cantidad de actividad BOLD para cada evento individual, deconvolucionamos la señal más compleja en sus partes individuales. La función base de una sola Función de Respuesta Hemodinámica (HRF) nos permite estimar cómo se vería la combinación de HRF que ocurren en diferentes momentos y con diferentes magnitudes, y estimamos la combinación que da lugar a la señal observada.

De forma similar a los datos ponderados por difusión, adquirimos una señal de difusión en cada vóxel desde muchos ángulos diferentes para formar una imagen tanto de la dirección de la difusión como de su magnitud. La señal se deconvoluciona entonces en un conjunto de fibras individuales orientadas en diferentes direcciones. En lugar de un único número de difusión en cada vóxel, se utiliza la deconvolución esférica para generar una función de densidad de orientación de la fibra , o FOD. La función se representa como una forma con ejes ovoides; y aunque los lóbulos del eje que carga en la dirección predominante de difusión se hacen más largos y grandes en relación con los otros ejes, la información sobre la dirección y la fuerza de la difusión a lo largo de los otros ejes aún se conserva.
../../_images/00_ODF.png

Se muestra una imagen ponderada por difusión con FOD superpuestos. Si ampliamos una región de la comisura anterior, observamos que los ODF se mueven principalmente de izquierda a derecha (lo que también se representa por su código de color rojo). Observe que los ODF a la derecha del recuadro comienzan a tornarse más verdes, lo que representa el cambio de orientación de un eje principalmente izquierda-derecha a un eje anteroposterior.
../../_imagenes/00_ODF_2.png

Otra parte de la sustancia blanca muestra FOD que siguen principalmente una orientación anteroposterior; sin embargo, algunas ODF tienen lóbulos que se extienden tanto en dirección anteroposterior como inferosuperior (la inferosuperior se codifica en azul). De esta manera, los FOD pueden representar la orientación de las fibras en múltiples dimensiones.

**Análisis de difusión con MRtrix**

Para este tutorial, utilizaremos el paquete de software MRtrix . Este programa utiliza el método de deconvolución esférica descrito anteriormente, además de técnicas avanzadas como la tractografía con restricciones anatómicas. Los resultados de MRtrix también pueden combinarse con las parcelaciones generadas por FreeSurfer para crear un conectoma que representa la conectividad de cada parcelación (también conocida como nodos en este contexto) con todos los demás nodos del cerebro. Todo esto y más se abordará en los siguientes capítulos.


Tutorial n.° 1 de MRtrix: Descargar e instalar
----------------------------------------------

La página de descarga de MRtrix contiene instrucciones de descarga e instalación para usuarios de Windows, Macintosh y Linux. Este proceso solía ser bastante largo, ya que era necesario descargar varias dependencias y bibliotecas. Afortunadamente, los desarrolladores han creado recientemente un comando de una sola línea que lo hará todo automáticamente:

.. code:: Bash

   sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"

Esto descargará e instalará todo el paquete MRtrix3 en su máquina, lo que no llevará más que unos pocos minutos.

Una vez descargado, abra una Terminal y escriba lo siguiente para probar su instalación:

.. code:: Bash
   
   mrview

Esto abrirá el visor de MRtrix. En la siguiente sección, descargaremos los datos de difusión, que puedes cargar en el visor haciendo clic y seleccionando la imagen de difusión. Debería verse así:File -> Open
../../_images/01_SampleImage.png

Intente también escribir uno de los comandos de la biblioteca, como mrconvert, y pulse enter. Si MRtrix se instaló correctamente, debería ver la página de ayuda impresa por defecto cuando no se pasan argumentos al comando:
../../_images/01_MRconvert.png

Si ambos funcionan sin errores, estará listo para comenzar a descargar datos de difusión, que abordaremos en el próximo capítulo.

**Video**

Puedes encontrar un vídeo tutorial para la instalación en Macintosh aquí .


Tutorial n.º 2 de MRtrix: Cómo descargar el conjunto de datos
-------------------------------------------------------------

En este curso, analizaremos un conjunto de datos de openneuro.org llamado BTC preop . Incluye datos de pacientes con gliomas, pacientes con meningiomas y un grupo de control. Compararemos los grupos entre sí y realizaremos análisis de correlación con las covariables incluidas en el participants.tsvarchivo del conjunto de datos.

Para descargar los datos haga clic en este enlace y luego en el Downloadbotón .
../../_images/02_Descargar_BTC.png

Cuando finalice la descarga, descomprima la carpeta, abra una Terminal y cámbiele el nombre a BTC_preop:

.. code:: Bash

   mv ~/Downloads/ds001226-00001 ~/Desktop/BTC_preop

Esto supone que el conjunto de datos se guardó en el directorio "Descargas". El comando colocará el directorio renombrado en su escritorio.

**Nota**

Si no tiene espacio para todos los datos, puede comenzar con los de un solo sujeto. Haga clic en la sub-CON02carpeta para expandir el contenido y descargue cada archivo por separado. Luego, cree las siguientes subcarpetas en su directorio BTC_preop; para ello, navegue hasta ese directorio y escriba `` . Después, mueva las imágenes que descargue a su directorio correspondiente; es decir, las imágenes anatómicas irán a la carpeta `anat`, las imágenes de difusión a la carpeta `dwi`, y así sucesivamente.mkdir -p sub-CON02/ses-preop/anat sub-CON02/ses-preop/dwi sub-CON02/ses-preop/func

Entonces estará listo para comenzar a mirar los datos en el próximo capítulo.

**Video**

Haga clic aquí para obtener una guía sobre cómo descargar el conjunto de datos.


Tutorial n.º 3 de MRtrix: Análisis de los datos
-----------------------------------------------

**Descripción general**

MRtrix utiliza su propio formato para almacenar y mostrar datos de imágenes. Si ya ha consultado los tutoriales de los principales paquetes de software de fMRI, como SPM, FSL y AFNI, recordará que todos pueden leer y escribir imágenes en formato NIFTI. (AFNI, por defecto, escribirá los archivos en su propio formato BRIK/HEAD, a menos que especifique que la salida tenga la extensión .nii, pero es la única excepción). MRtrix también puede leer datos sin procesar en formato NIFTI, pero generará sus archivos en formato MRtrix, etiquetados con una .mifextensión.

Para ver cómo funciona, dirígete a la carpeta sub-CON02/ses-preop/dwique contiene tus datos de difusión. Uno de los primeros pasos para preprocesar tus datos es convertirlos a un formato compatible con MRtrix. Usaremos el comando mrconvertpara combinar los datos de difusión sin procesar con sus archivos correspondientes .bval, .bvecde modo que podamos usar el archivo combinado para futuros pasos de preprocesamiento:

.. code:: Bash

   mrconvert sub-CON02_ses-preop_acq-AP_dwi.nii.gz sub-02_dwi.mif -fslgrad sub-CON02_ses-preop_acq-AP_dwi.bvec sub-CON02_ses-preop_acq-AP_dwi.bval

Este comando requiere tres argumentos: la entrada, que es el archivo DWI sin procesar en el directorio AP; un archivo de salida, que llamaremos sub-02_dwi.mif para hacerlo más compacto y fácil de leer; y -fslgrad, que requiere los archivos .bvec y .bval correspondientes (en ese orden).

**Nota**

Para que el resto del tutorial también sea más fácil de leer, use el mvcomando para cambiar el nombre de los archivos .bval y .bvec:

.. code:: Bash

   mv sub-CON02_ses-preop_acq-AP_dwi.bvec sub-02_AP.bvec
   mv sub-CON02_ses-preop_acq-AP_dwi.bval sub-02_AP.bval
   mv sub-CON02_ses-preop_acq-PA_dwi.bvec sub-02_PA.bvec
   mv sub-CON02_ses-preop_acq-PA_dwi.bval sub-02_PA.bval

La imagen de salida, sub-02_dwi.mif, se puede comprobar con el comando mrinfo:

.. code:: Bash

   mrinfo sub-02_dwi.mif

La salida contiene varios datos, como las dimensiones del conjunto de datos y el tamaño del vóxel, junto con los comandos que se utilizaron para generar el archivo actual:
../../_images/03_mrinfo_output.png

Tenga en cuenta que, al tratarse de un conjunto de datos de 4 dimensiones, la última dimensión es el tiempo ; es decir, este archivo contiene 102 volúmenes, cada uno con dimensiones de 96 x 96 x 60 vóxeles. La última dimensión del campo, que en este caso tiene un valor de 8,7, indica el tiempo de adquisición de cada volumen. Este tiempo también se denomina tiempo de repetición o TR.Voxel size

**Bvals y Bvecs**

Los otros archivos que debemos revisar son los archivos bvals y bvecs . (Para una revisión más completa del significado de estos términos, consulte este capítulo ). En resumen, los archivos bvals contienen un único número por volumen que indica la magnitud del gradiente de difusión aplicado a los datos; y el archivo bvecs contiene un triplete de números por volumen que muestra la dirección en la que se aplicaron los gradientes. En general, los volúmenes con valores b mayores serán más sensibles a los cambios de difusión, pero las imágenes también serán más susceptibles al movimiento y a los artefactos fisiológicos, como se muestra en la figura siguiente.
../../_images/03_bvals.png

Tres volúmenes con diferentes valores b. Un valor b de 0 equivale a una exploración funcional ponderada en T2, mientras que valores b más altos resultan en una menor calidad de imagen (pero mayor sensibilidad a la difusión).

La comprobación más importante es asegurar que el número de bvals y bvecs coincida con el número de volúmenes del conjunto de datos. Por ejemplo, podemos encontrar el número de volúmenes del sub-02_dwi.mifconjunto de datos escribiendo:

.. code:: Bash

   mrinfo -size sub-02_dwi.mif | awk '{print $4}'

Esto devuelve un valor de 102, el número en el cuarto campo del encabezado de dimensiones que corresponde al número de puntos de tiempo, o volúmenes, en el conjunto de datos. Luego, comparamos esto con el número de bvals y bvecs usando awk para contar el número de columnas en cada archivo de texto:

.. code:: Bash

   awk '{print NF; exit}' sub-02_AP.bvec
   awk '{print NF; exit}' sub-02_AP.bval

Lo cual debería devolver un valor de 102.

**Nota**

Si la cantidad de volúmenes en su conjunto de datos y la cantidad de bvals y bvecs no coinciden, debe consultar con su técnico de escaneo acerca de la discrepancia; es posible que los archivos no se hayan cargado correctamente al servidor o tal vez la imagen ponderada por difusión no se adquirió correctamente.

**Mirando los datos con mrview**

MRtrix, al igual que los demás programas de imágenes que hemos tratado en este libro electrónico, cuenta con su propio visor de imágenes, llamado mrview . Por ejemplo, puede ver la imagen que creamos arriba escribiendo:

.. code:: Bash

   mrview sub-02_dwi.mif

Esto abre un único panel de visualización de los cortes axiales:
../../_images/03_mrview_axial.png

Puede ver los tres ángulos de visión haciendo clic en “Ver” y luego seleccionando “Vista ortogonal”, lo que cambiará la ventana a la siguiente:
../../_images/03_mrview_ortho.png

Al hacer clic y arrastrar la cruceta, se puede examinar el cerebro completo desde los tres puntos de vista. Observe que estamos viendo el primer volumen de una serie temporal y que podemos desplazarnos por las imágenes pulsando las flechas derecha e izquierda para avanzar o retroceder. El primer volumen mostrado, cuyo índice de serie temporal es 0 (es decir, 0 indica el primer volumen de la serie temporal, 1 el segundo, y así sucesivamente), parece una imagen funcional típica ponderada en T2. ​​Podemos verificarlo comparándolo con el valor b del primer volumen de la serie temporal:
../../_images/03_mrview_firstVolume_bval.png

Ahora pase el ratón sobre la ventana de visualización de mrview y pulse la flecha derecha para cargar el siguiente volumen de la serie temporal. Si observa el archivo bval, ¿esperaría que esta imagen se viera similar o diferente a la que acaba de ver? ¿Por qué? Piense en esto al cargar la tercera y la cuarta imagen de la serie temporal, observando las diferencias de intensidad y su correspondencia con sus respectivos valores b. Si la disminución de la intensidad oscurece la imagen, puede aumentar el brillo haciendo clic en y, a continuación, introduciendo un valor máximo inferior en el campo "Escala de intensidad".Tool -> View options
../../_images/03_mrview_IntensityScaling.png

**Video**

Puedes seguir este vídeo para aprender más sobre cómo comprobar los datos.

**Próximos pasos**

Una vez que haya practicado la observación de los datos y haya observado la relación entre los valores b y los volúmenes, intente lo mismo con la imagen ponderada por difusión con codificación de fase en la dirección PA (es decir, sub-CON02_ses-preop_dwi_sub-CON02_ses-preop_acq-PA_dwi.nii.gz). ¿Cuántos volúmenes hay en este conjunto de datos? ¿Cuáles son los valores b? ¿Cómo se compara con lo observado en el conjunto de datos ponderado por difusión AP?

Ahora que ha aprendido algunos de los comandos y conceptos básicos de MRtrix, comenzaremos a preprocesar los datos para ajustar las líneas de corriente . Para comenzar, haga clic en el Nextbotón.
Monetice su audiencia: financie un proyecto o sitio web de OSS con EthicalAds, una red publicitaria que prioriza la privacidad.


Tutorial n.° 4 de MRtrix: Preprocesamiento
------------------------------------------

**Descripción general**

Al igual que otros datos de neuroimagen, los datos de difusión deben preprocesarse antes de su análisis. El preprocesamiento elimina las fuentes de ruido de la imagen, como artefactos de movimiento y otras distorsiones. Los datos de difusión, en particular, son susceptibles a artefactos de distorsión debido a la dirección de codificación de fase: en general, la dirección de codificación predominante, como Anterior-Posterior (AP), hará que la parte anterior del cerebro se vea más compacta, como si soplara un fuerte viento en contra desde la dirección anterior. Lo contrario ocurre con la dirección de codificación de fase Posterior-Anterior (PA). A veces, estas distorsiones son muy sutiles, pero otras veces son evidentes.
../../_images/04_AP_PA_Comparaciones.png

Los siguientes son pasos comunes de preprocesamiento realizados con MRtrix. Si ha utilizado el paquete de software FSL para analizar datos de difusión, tenga en cuenta que algunos comandos de FSL, como eddy y topup, se utilizan en algunas bibliotecas de MRtrix. Analizaremos esto con más detalle a continuación.

**dwi_denoise**

El primer paso de preprocesamiento que realizaremos es eliminar el ruido de los datos mediante dwidenoiseel comando de MRtrix. Esto requiere un argumento de entrada y uno de salida, y también se puede generar el mapa de ruido con la -noiseopción. Por ejemplo:

.. code::

   dwidenoise sub-02_dwi.mif sub-02_den.mif -noise noise.mif

Este comando debería tardar un par de minutos en ejecutarse.

Una comprobación de calidad consiste en comprobar si los residuos se cargan en alguna parte de la anatomía. De ser así, podría indicar que la región cerebral se ve afectada de forma desproporcionada por algún tipo de artefacto o distorsión. Para calcular este residuo, utilizaremos otro comando de MRtrix llamado mrcalc:

.. code:: Bash

   mrcalc sub-02_dwi.mif sub-02_den.mif -subtract residual.mif

Luego puedes inspeccionar el mapa residual con mrview:

.. code:: Bash

   mrview residual.mif

../../_imagenes/04_residuales.png

Es común ver un contorno gris del cerebro, como en la figura anterior. Sin embargo, todo dentro de la materia gris y la materia blanca debería ser relativamente uniforme y borroso; si se observan puntos de referencia anatómicos claros, como circunvoluciones o surcos individuales, esto podría indicar que esas partes del cerebro han sido alteradas por el ruido. En tal caso, se puede aumentar la intensidad del filtro de eliminación de ruido del valor predeterminado de 5 a un número mayor, como 7; por ejemplo,

.. code:: Bash

   dwidenoise your_data.mif your_data_denoised_7extent.mif -extent 7 -noise noise.mif

**resonancia magnética_degibbs**

Un paso opcional de preprocesamiento es ejecutar [ ] mri_degibbs, lo cual elimina los artefactos de anillo de Gibbs de los datos. Estos artefactos se asemejan a las ondas en un estanque y son más visibles en las imágenes con un valor b de 0. Analice primero sus datos de difusión con [ mrview] y determine si existen artefactos de Gibbs; si los hay, puede ejecutar [ ] mrdegibbsespecificando un archivo de entrada y uno de salida, por ejemplo:

.. code:: Bash

   mrdegibbs sub-02_den.mif sub-02_den_unr.mif

Como siempre, inspeccione los datos antes y después mrviewpara determinar si el paso de preprocesamiento mejoró o empeoró los datos o no tuvo ningún efecto.

Si no ve ningún artefacto de Gibbs en sus datos, le recomiendo omitir este paso; no lo usaremos durante el resto del tutorial.

**Extracción de imágenes codificadas en fase inversa**

La mayoría de los conjuntos de datos de difusión se componen de dos archivos de imágenes independientes: uno adquirido con codificación de fase primaria y otro con codificación de fase inversa. La codificación de fase primaria se utiliza para adquirir la mayoría de las imágenes de difusión con diferentes valores b. El archivo con codificación de fase inversa, por otro lado, se utiliza para corregir las distorsiones presentes en el archivo con codificación de fase primaria.

Para entender cómo funciona esto, imagina que usas un secador. Supongamos que apuntas el secador hacia la nuca y sopla el cabello hacia adelante, sobre la cara; a esto lo llamamos dirección de codificación de fase de posterior a anterior (PA). Ahora mismo, tu cabello luce desordenado y quieres contrarrestar el efecto del aire que sopla de la nuca a la frente. Así que apuntas el secador hacia la cara y sopla el cabello hacia atrás. Si calculas el promedio entre ambos secados, tu cabello debería volver a su posición normal.

De forma similar, utilizamos ambas direcciones de codificación de fase para crear una especie de promedio entre ambas. Sabemos que ambos tipos de codificación de fase introducirán dos distorsiones distintas y opuestas en los datos, pero podemos usar la corrección de distorsión para cancelarlas.

Nuestro primer paso es convertir el archivo NIFTI con codificación de fase inversa al formato .mif. También añadiremos sus valores b y vectores b en el encabezado:

.. code:: Bash

   mrconvert sub-CON02_ses-preop_acq-PA_dwi.nii.gz PA.mif
   mrconvert PA.mif -fslgrad sub-02_PA.bvec sub-02_PA.bval - | mrmath - mean mean_b0_PA.mif -axis 3

A continuación, extraemos los valores b de la imagen codificada en fase primaria y luego combinamos los dos con mrcat:

.. code:: Bash

   dwiextract sub-02_den.mif - -bzero | mrmath - mean mean_b0_AP.mif -axis 3
   mrcat mean_b0_AP.mif mean_b0_PA.mif -axis 3 b0_pair.mif

Esto creará una nueva imagen, “b0_pair.mif”, que contiene ambas imágenes b=0 promedio para ambas imágenes codificadas por fase.

**Juntándolo todo: preprocesamiento con dwipreproc**

Ahora tenemos todo lo necesario para ejecutar el paso principal de preprocesamiento, llamado por dwipreproc. En su mayor parte, este comando es un contenedor que utiliza comandos FSL como topupy eddypara deshacer la distorsión de los datos y eliminar las corrientes de Foucault. Para este tutorial, usaremos la siguiente línea de código:

.. code:: Bash

   dwifslpreproc sub-02_den.mif sub-02_den_preproc.mif -nocleanup -pe_dir AP -rpe_pair -se_epi b0_pair.mif -eddy_options " --slm=linear --data_is_shelled"

Los primeros argumentos son la entrada y la salida; la segunda opción, -nocleanup, mantendrá la carpeta de procesamiento temporal que contiene algunos archivos que examinaremos más adelante. indica que la dirección de codificación de fase primaria es anteroposterior y, combinada con las opciones, indica que el siguiente archivo de entrada (es decir, “b0_pair.mif”) es un par de imágenes de eco de espín que se adquirieron con direcciones de codificación de fase inversa. Por último, especifica opciones específicas del comando FSL . Puede visitar la guía del usuario de eddy para obtener más opciones y detalles sobre su función. Por ahora, solo usaremos las opciones (que pueden ser útiles para datos adquiridos con menos de 60 direcciones) y (que indica que los datos de difusión se adquirieron con múltiples valores b).-pe_dir AP-rpe_pair-se_epi-eddy_optionseddy--slm=linear--data_is_shelled

Este comando puede tardar varias horas en ejecutarse, dependiendo de la velocidad de su computadora. En una iMac con 8 núcleos de procesamiento, tarda aproximadamente 2 horas. Una vez finalizado, examine la salida para ver cómo la corrección de corrientes parásitas y la corrección de la distorsión han cambiado los datos; idealmente, debería observar una mayor restauración de la señal en regiones como la corteza orbitofrontal, que es particularmente susceptible a la pérdida de señal.

.. code:: Bash

   mrview sub-02_den_preproc.mif -overlay.load sub-02_dwi.mif

Este comando mostrará los datos recién preprocesados, con los datos de difusión originales superpuestos y coloreados en rojo. Para ver cómo se corrigieron las corrientes de Foucault, abra la pestaña Superposiciones y haga clic en el cuadro junto a la imagen sub-02_dwi.mif. Debería observar una diferencia notable entre las dos imágenes, especialmente en los lóbulos frontales del cerebro, cerca de los ojos, que son más susceptibles a las corrientes de Foucault.
../../_images/04_BeforeAfterEddy.png

**Comprobación de porciones corruptas**

Una de las opciones del dwifslpreproccomando, "-nocleanup", conservó un directorio con la cadena "tmp" en su título. Dentro de esta carpeta hay un archivo llamado dwi_post_eddy.eddy_outlier_map, que contiene cadenas de 0 y 1. Cada 1 representa un segmento atípico, ya sea por exceso de movimiento, corrientes de Foucault u otra causa.

El siguiente código, ejecutado desde el dwidirectorio, navegará a la carpeta “tmp” y calculará el porcentaje de sectores con valores atípicos:

.. code:: Bash

   cd dwifslpreproc-tmp-*
   totalSlices=`mrinfo dwi.mif | grep Dimensions | awk '{print $6 * $8}'`
   totalOutliers=`awk '{ for(i=1;i<=NF;i++)sum+=$i } END { print sum }' dwi_post_eddy.eddy_outlier_map`
   echo "If the following number is greater than 10, you may have to discard this subject because of too much motion or corrupted slices"
   echo "scale=5; ($totalOutliers / $totalSlices * 100)/1" | bc | tee percentageOutliers.txt
   cd ..

Las dos primeras líneas acceden al directorio "tmp" y calculan el número total de segmentos multiplicando el número de segmentos de un volumen por el número total de volúmenes del conjunto de datos. A continuación, se calcula el número total de unos en el mapa de valores atípicos, y el porcentaje de segmentos con valores atípicos se genera dividiendo el número de segmentos con valores atípicos entre el número total de segmentos. Si este número es mayor que 10 (es decir, si más del 10 % de los segmentos se marcan como atípicos), debería considerar eliminar el sujeto de los análisis posteriores.

**Generando una máscara**

Al igual que con el análisis fMRI, es útil crear una máscara para restringir el análisis solo a los vóxeles del cerebro; esto acelerará el resto de los análisis.

Para ello, puede ser útil ejecutar previamente un comando llamado dwibiascorrect. Esto puede eliminar las inhomogeneidades detectadas en los datos, lo que puede conducir a una mejor estimación de la máscara. Sin embargo, en algunos casos puede resultar en una estimación deficiente; como con todos los pasos de preprocesamiento, conviene comprobarlo antes y después de cada paso:

.. code:: Bash

   dwibiascorrect ants sub-02_den_preproc.mif sub-02_den_preproc_unbiased.mif -bias bias.mif

**Nota**

El comando anterior usa la -antsopción , que requiere que ANTs esté instalado en su sistema. Recomiendo este programa, pero si no puede instalarlo, puede reemplazarlo con la -fslopción .

Ahora está listo para crear la máscara con dwi2mask, que restringirá su análisis a los vóxeles que se encuentran dentro del cerebro:

.. code:: Bash

   dwi2mask sub-02_den_preproc_unbiased.mif mask.mif

Compruebe la salida de este comando escribiendo:

.. code::

   mrview mask.mif

Deberías ver algo como lo siguiente:
../../_images/04_Mask.png

El comando dwi2mask de MRtrix funciona bien en la mayoría de los casos. Sin embargo, en la imagen superior se puede ver que la máscara tiene algunos agujeros en el tronco encefálico y el cerebelo. Puede que estas regiones no le interesen, pero conviene asegurarse de que la máscara no tenga agujeros.

Para ello, podría usar un comando como el de FSL bet2. Por ejemplo, podría usar el siguiente código para convertir la imagen ponderada por difusión no sesgada al formato NIFTI, crear una máscara con bet2y luego convertirla al formato .mif:

.. code:: Bash

   mrconvert sub-02_den_preproc_unbiased.mif sub-02_unbiased.nii
   bet2 sub-02_unbiased.nii sub-02_masked -m -f 0.7
   mrconvert sub-02_masked_mask.nii.gz mask.mif

Quizás tengas que experimentar con el umbral de intensidad fraccional (especificado por -f) para generar una máscara satisfactoria. En mi experiencia, este puede variar entre 0,2 y 0,7 en la mayoría de los cerebros para generar una máscara adecuada.

**Video**


Puede encontrar una descripción general en video del preprocesamiento en MRtrix aquí .

**Próximos pasos**

Ahora que tenemos nuestros datos de difusión preprocesados ​​y una máscara, estamos listos para realizar la deconvolución esférica restringida , que cubriremos en el próximo capítulo.



Tutorial n.º 5 de MRtrix: Deconvolución esférica restringida
------------------------------------------------------------

Descripción general

Para determinar la orientación de la difusión dentro de cada vóxel, crearemos una función base a partir de los datos del sujeto. Al extraer la señal de difusión de vóxeles representativos de materia gris, materia blanca y líquido cefalorraquídeo, construiremos un modelo para estimar cómo debería verse la señal en diferentes orientaciones y al aplicar diferentes valores b. El concepto es similar al uso de una función de respuesta hemodinámica (HRF) como función base para datos de fMRI: obtenemos una forma canónica de cómo creemos que debería verse la señal fMRI en respuesta a un solo evento y luego la modulamos para ajustarla a los datos observados.

La función de respuesta es similar a la HRF canónica que utilizamos en estudios de fMRI. Sin embargo, en este caso, estimamos la función de respuesta para cada tipo de tejido. Si recopila datos de difusión con múltiples valores b, este enfoque en MRtrix se denomina multicapa multitejido (MSMT) .
respuesta dwi2

A diferencia de la mayoría de los estudios de fMRI, que utilizan una función base creada previamente, MRtrix derivará una función base a partir de los datos de difusión; usar los datos de un sujeto individual es más preciso y específico para ese sujeto. El comando dwi2responseofrece varios algoritmos diferentes, pero en este tutorial utilizaremos el algoritmo "dhollander":

dwi2response dhollander sub-02_den_preproc_unbiased.mif wm.txt gm.txt csf.txt -voxels voxels.mif

Analicemos la función de este comando. Primero, utiliza un algoritmo para deconvolucionar las distribuciones de orientación de las fibras (FOD) ; en otras palabras, intenta descomponer la señal de difusión en un conjunto de orientaciones de fibras individuales más pequeñas. Existen varios algoritmos, pero los más comunes son Tournier y Dhollander. El algoritmo Tournier se utiliza para datos de una sola capa y para un solo tipo de tejido (p. ej., sustancia blanca). El algoritmo Dhollander puede utilizarse para datos de una o varias capas, y para múltiples tipos de tejido. Estimar la FOD para cada tipo de tejido nos ayudará posteriormente a realizar tractografías con restricciones anatómicas.

El siguiente argumento especifica los datos de entrada y las funciones de respuesta resultantes para los diferentes tipos de tejido. El orden es importante; puede nombrar los archivos de salida como desee, pero lo más lógico es etiquetarlos como una variación de las frases "materia blanca", "materia gris" y "líquido cefalorraquídeo" (en este caso, etiquetados como "wm.txt", "gm.txt" y "csf.txt"). La última opción, "-voxels", especifica un conjunto de datos de salida que muestra qué vóxeles de la imagen se utilizaron para construir las funciones base para cada tipo de tejido. Este conjunto de datos se puede visualizar escribiendo lo siguiente:

mrview sub-02_den_preproc_unbiased.mif -overlay.load voxels.mif

Lo que generará algo como esto:
../../_imágenes/05_voxels.png

El resultado del dwi2responsecomando muestra los vóxeles utilizados para construir una función base para cada tipo de tejido. Rojo: vóxeles de LCR; Verde: vóxeles de materia gris; Azul: vóxeles de materia blanca. Asegúrese de que estos colores estén ubicados correctamente; por ejemplo, los vóxeles rojos deben estar dentro de los ventrículos.

Luego puede verificar la función de respuesta para cada tipo de tejido escribiendo:

shview wm.txt
shview gm.txt
shview csf.txt

Examine cada uno de estos archivos individualmente. La primera imagen que aparece parece una esfera; esto representa el aspecto de la difusión en ese tipo de tejido cuando se aplica un valor b de cero; es decir, cuando no hay gradiente de difusión. Al presionar las teclas de flecha derecha e izquierda, puede ver el aspecto de la función base cuando se aplican diferentes valores b.

La figura a continuación muestra cómo cambia la función base para cada combinación de tipo de tejido y valor b. Observe cómo la magnitud (o tamaño) general de la esfera para cada tipo de tejido se reduce al aplicar valores b más altos; aunque los valores b más altos son más sensibles a los cambios en la difusión, la señal general es menor y más susceptible al ruido. Dentro de la sustancia blanca, la esfera tiende a aplanarse formando una especie de panqueque al aplicar gradientes de difusión, lo que refleja la dirección preferencial de la difusión a lo largo de los tractos de sustancia blanca en estos vóxeles. Por otro lado, para la sustancia gris y el líquido cefalorraquídeo, la función base permanece esférica en todos los valores b.

Nota

Las funciones base de la materia gris y del líquido cefalorraquídeo tienden a disminuir a ritmos diferentes a medida que aumentan los valores b. ¿A qué cree que se debe esto?
../../_images/05_bvals_tissues.png
Densidad de orientación de la fibra (FOD)

Ahora utilizaremos las funciones base generadas anteriormente para crear densidades de orientación de la fibra (FOD). Estas son estimaciones de la cantidad de difusión en cada una de las tres direcciones ortogonales. Como se describe en el capítulo introductorio , son análogas a los tensores utilizados en los estudios de difusión tradicionales. Sin embargo, MRtrix permite la estimación de múltiples fibras cruzadas dentro de un solo vóxel y puede resolver la señal de difusión en múltiples direcciones.

Para ello, usaremos el comando dwi2fodpara aplicar las funciones base a los datos de difusión. La opción "-mask" especifica los vóxeles que utilizaremos; esto simplemente sirve para restringir nuestro análisis a los vóxeles cerebrales y reducir el tiempo de cálculo. Los archivos ".mif" especificados después de cada función base generarán una imagen FOD para ese tipo de tejido:

dwi2fod msmt_csd sub-02_den_preproc_unbiased.mif -mask mask.mif wm.txt wmfod.mif gm.txt gmfod.mif csf.txt csffod.mif

Para visualizar estos FOD, los combinaremos en una sola imagen. El comando mrconvertextraerá la primera imagen del archivo wmfod.mif, que es la imagen con un valor b de 0. La salida de este comando se utiliza como entrada para un mrcatcomando que combina las imágenes FOD de los tres tipos de tejido en una sola imagen que llamaremos "vf.mif":

mrconvert -coord 3 0 wmfod.mif - | mrcat csffod.mif gmfod.mif - vf.mif

Los FOD de materia blanca se pueden superponer en esta imagen, de modo que podamos observar si los FOD de materia blanca efectivamente caen dentro de la materia blanca, y también si están a lo largo de las orientaciones que esperaríamos:

mrview vf.mif -odf.load_sh wmfod.mif

El resultado será algo como esto:
../../_images/05_FODs.png

Los FOD de la sustancia blanca se superponen en una imagen con código de colores para cada tipo de tejido. El verde representa la sustancia gris, el líquido cefalorraquídeo se representa en rojo y la sustancia blanca se muestra en azul.

Puede ampliar la imagen manteniendo pulsada commandla rueda del ratón y desplazándola. Céntrese en una región como el cuerpo calloso; si los FOD se han estimado correctamente, el color predominante en el cuerpo calloso debería ser el rojo, ya que este indica que la orientación principal es de izquierda a derecha.
../../_imagenes/05_FODs_CC.png

Recuerda que el verde significa de posterior a anterior y el azul representa las orientaciones de inferior a superior. Utilizando las tres vistas ortogonales, observa si puedes encontrar tractos como el fascículo longitudinal superior y la corona radiada. ¿Coinciden con los colores esperados?
Normalización

Más adelante, aprenderemos a realizar un análisis a nivel de grupo con los datos generados para cada sujeto. Para que las comparaciones entre sujetos sean válidas, necesitaremos normalizar los FOD. Esto garantiza que las diferencias observadas no se deban a diferencias de intensidad en la imagen, de forma similar a cómo corregimos el tamaño del cerebro al comparar las diferencias volumétricas entre sujetos.

Para normalizar los datos, usaremos el mtnormalisecomando. Esto requiere una entrada y una salida para cada tipo de tejido, así como una máscara para restringir el análisis a los vóxeles cerebrales:

mtnormalise wmfod.mif wmfod_norm.mif gmfod.mif gmfod_norm.mif csffod.mif csffod_norm.mif -mask mask.mif

Video

Haga clic aquí para ver una demostración de cómo crear funciones base en MRtrix.
Próximos pasos

Ahora que hemos estimado correctamente los FOD para cada tipo de tejido, estamos listos para sentar las bases de nuestro análisis tractográfico. El siguiente paso será determinar el límite entre la materia gris y la materia blanca, que usaremos como punto de partida para nuestras líneas de corriente.


------------------------------------------------------------------------------------------

Tutorial n.° 6 de MRtrix: Creación de los límites del tejido

Estamos casi listos para comenzar nuestro análisis de líneas de corriente, en el que colocaremos semillas en puntos aleatorios a lo largo del límite entre la materia gris y la blanca. Una línea de corriente crecerá desde cada semilla y trazará un camino desde esa región hasta terminar en otra. Algunas líneas de corriente terminarán en lugares sin sentido; por ejemplo, una línea de corriente podría terminar en el borde de los ventrículos. Descartaremos estas líneas de corriente "erróneas" y nos quedará la mayoría de las que parecen conectar regiones distantes de materia gris.

Para ello, primero debemos crear un límite entre la materia gris y la blanca. El comando MRtrix 5ttgenutilizará FAST de FSL, junto con otros comandos, para segmentar la imagen anatómica en cinco tipos de tejido:

    Materia gris;

    Materia gris subcortical (como la amígdala y los ganglios basales);

    materia blanca;

    Líquido cefalorraquídeo; y

    Tejido patológico.

Una vez que hayamos segmentado el cerebro en esas clases de tejido, podemos usar el límite como una máscara para restringir dónde colocaremos nuestras semillas.
Conversión de la imagen anatómica

Primero, es necesario convertir la imagen anatómica al formato MRtrix. Al igual que en un capítulo anterior, usaremos el comando mrconvert. Si se encuentra en el dwidirectorio, puede escribir lo siguiente:

mrconvert ../anat/sub-CON02_ses-preop_T1w.nii.gz T1.mif

Esto crea un nuevo archivo, T1.mif, que puedes ver en mrview.

Ahora usaremos el comando 5ttgenpara segmentar la imagen anatómica en los tipos de tejido enumerados anteriormente:

5ttgen fsl T1.mif 5tt_nocoreg.mif

Este comando tardará entre 10 y 15 minutos. Si la segmentación se ha completado correctamente, debería ver las siguientes imágenes al escribir (al pulsar las flechas izquierda y derecha se desplaza por los diferentes tipos de tejido):mrview 5tt_nocoreg.mif
../../_images/06_TiposDeTejido.png

El resultado será un único conjunto de datos con cinco volúmenes, uno por tipo de tejido. Revise esta imagen con mrview, usando las flechas derecha e izquierda para alternar entre los tipos de tejido. Los tipos de tejido son: tejido general (GM), tejido de la membrana celular (WM), LCR, tejido general subcortical (GM) y tejido patológico. Si no se detecta tejido patológico, el volumen estará en blanco.5ttgen fsl anat.mif 5tt_nocoreg.mif

Nota

Si el paso de segmentación falla, puede deberse a un contraste insuficiente entre los tipos de tejido; por ejemplo, algunas imágenes anatómicas son muy oscuras tanto en la sustancia gris como en la blanca, o muy claras en ambos tipos de tejido. Podemos facilitar el proceso de segmentación aumentando el contraste de intensidad (también conocido como normalización de intensidad ) entre los tejidos con un comando como 3dUnifize de AFNI, por ejemplo:

3dUnifize -input anat.nii -prefix anat_unifize.nii

La diferencia entre la imagen antes y después puede ser sutil, pero puede evitar que se produzca un error de segmentación.
Registro conjunto de imágenes de difusión y anatómicas

Si la segmentación ha finalizado sin errores, el siguiente paso es corregistrar las imágenes anatómicas y ponderadas por difusión. Esto garantiza que los límites de los tipos de tejido coincidan con los de las imágenes ponderadas por difusión; incluso pequeñas diferencias en la ubicación de las dos exploraciones pueden distorsionar los resultados de la tractografía.

Primero usaremos los comandos dwiextracty mrmathpara promediar las imágenes B0 de los datos de difusión. Estas imágenes se asemejan más a las exploraciones funcionales ponderadas en T2, ya que no se aplicó un gradiente de difusión durante su adquisición; es decir, se adquirieron con un valor b de cero. Para ver cómo funciona, regrese al dwidirectorio y escriba el siguiente comando:

dwiextract sub-02_den_preproc_unbiased.mif - -bzero | mrmath - mean mean_b0.mif -axis 3

Este comando consta de dos partes, separadas por una barra vertical ('' |''). La mitad izquierda del comando, dwiextract, toma como entrada la imagen preprocesada ponderada por difusión, y la -bzeroopción extrae las imágenes B0; el -argumento único indica que la salida debe utilizarse como entrada para la segunda parte del comando, a la derecha de la barra vertical. mrmathLuego, toma estas imágenes B0 de salida y calcula la media a lo largo del tercer eje, o la dimensión temporal. En otras palabras, si comenzamos con un índice de 0, el número 3 indica la cuarta dimensión, lo que significa promediar todos los volúmenes.

Para realizar el corregistro entre las imágenes de difusión y anatómicas, necesitaremos realizar una breve desviación de MRtrix. El paquete de software no incluye un comando de corregistro en su biblioteca, por lo que necesitaremos usar los comandos de otro paquete. Aunque puede elegir el que prefiera, aquí nos centraremos en flirtel comando de FSL.

El primer paso es convertir tanto la imagen anatómica segmentada como las imágenes B0 que acabamos de extraer:

mv ../anat/5tt_nocoreg.mif .
mrconvert mean_b0.mif mean_b0.nii.gz
mrconvert 5tt_nocoreg.mif 5tt_nocoreg.nii.gz

Dado que flirtsolo se puede trabajar con una única imagen 3D (no conjuntos de datos 4D), utilizaremos fslroipara extraer el primer volumen del conjunto de datos segmentado, que corresponde a la segmentación de materia gris:

fslroi 5tt_nocoreg.nii.gz 5tt_vol0.nii.gz 0 1

Luego usamos el flirtcomando para registrar conjuntamente los dos conjuntos de datos:

flirt -in mean_b0.nii.gz -ref 5tt_vol0.nii.gz -interp nearestneighbour -dof 6 -omat diff2struct_fsl.mat

Este comando utiliza la segmentación de materia gris (es decir, “5tt_vol0.nii.gz”) como imagen de referencia, lo que significa que permanece estacionaria. Las imágenes B0 promediadas se desplazan para encontrar la que mejor se ajuste a la segmentación de materia gris. La salida de este comando, “diff2struct_fsl.mat”, contiene la matriz de transformación utilizada para superponer la imagen de difusión sobre la segmentación de materia gris.

Ahora que hemos generado nuestra matriz de transformación, debemos convertirla a un formato legible para MRtrix. Es decir, estamos listos para volver a MRtrix tras salir brevemente de él. El comando transformconverthace lo siguiente:

transformconvert diff2struct_fsl.mat mean_b0.nii.gz 5tt_nocoreg.nii.gz flirt_import diff2struct_mrtrix.txt

Tenga en cuenta que los pasos anteriores utilizaron la segmentación anatómica como imagen de referencia. Esto se debe a que, por lo general, el corregistro es más preciso si la imagen de referencia tiene mayor resolución espacial y una distinción más nítida entre los tipos de tejido. Sin embargo, también queremos minimizar las ediciones e interpolaciones en los datos funcionales durante el preprocesamiento. Por lo tanto, dado que ya contamos con los pasos para transformar la imagen de difusión en la imagen anatómica, podemos usar la matriz inversa de transformación para hacer lo contrario, es decir, corregistrar la imagen anatómica en la imagen de difusión.

mrtransform 5tt_nocoreg.mif -linear diff2struct_mrtrix.txt -inverse 5tt_coreg.mif

El archivo resultante, “5tt_coreg.mif”, se puede cargar mrviewpara examinar la calidad del registro conjunto:

mrview sub-02_den_preproc_unbiased.mif -overlay.load 5tt_nocoreg.mif -overlay.colourmap 2 -overlay.load 5tt_coreg.mif -overlay.colourmap 1

Las opciones "overlay.colourmap" especifican diferentes códigos de color para cada imagen cargada. En este caso, los límites antes del corregistro se mostrarán en azul y los límites después del corregistro, en rojo.
../../_images/06_GM_Alignment.png

El cambio en los límites antes y después del registro conjunto puede ser muy leve, pero tendrá un gran impacto en el resto de los pasos. Asegúrese de revisar los límites en las tres vistas; también puede usar el menú para mostrar u ocultar las diferentes superposiciones.Tool -> Overlay

El último paso para crear el límite de “semilla” (el límite que separa la materia gris de la materia blanca, que usaremos para crear las semillas de nuestras líneas de corriente) se crea con el comando 5tt2gmwmi(que significa “5 Tipo de tejido (segmentación) a interfaz de materia gris/materia blanca”)

5tt2gmwmi 5tt_coreg.mif gmwmSeed_coreg.mif

Nuevamente, verificaremos el resultado para mrviewasegurarnos de que la interfaz esté donde creemos que debería estar:

mrview sub-02_den_preproc_unbiased.mif -overlay.load gmwmSeed_coreg.mif

Deberías ver algo como esto al final:
../../_images/06_GMWMI.png
Video

Puedes encontrar un video tutorial sobre la creación de los límites del tejido aquí .
Próximos pasos

Ahora que hemos determinado dónde está el límite entre la materia gris y la blanca, estamos listos para empezar a generar líneas de corriente para reconstruir las principales vías de la materia blanca del cerebro. Veremos cómo hacerlo en el próximo capítulo.

-----------------------------------------------------------------------------

Tutorial n.° 7 de MRtrix: Líneas de corriente
Descripción general

Tras crear la interfaz entre la materia blanca y la materia gris, estamos listos para generar líneas de corriente : hilos que conectan regiones anatómicamente distintas de la materia gris. Estas son estimaciones de los tractos de materia blanca subyacentes, y MRtrix utiliza un enfoque probabilístico para ello: se genera un gran número de líneas de corriente para cada vóxel del límite entre la materia gris y la materia blanca, y luego se seleccionan según diferentes criterios que especificamos. A continuación, analizaremos algunas de las opciones más populares.
Tractografía anatómicamente restringida

Una de las características de MRtrix es la Tractografía Anatómicamente Restringida (ACT). Este método solo determina la validez de una línea de corriente si es biológicamente plausible. Por ejemplo, una línea de corriente que termina en el líquido cefalorraquídeo se descarta, ya que los tractos de sustancia blanca tienden a originarse y terminar en la sustancia gris. En otras palabras, las líneas de corriente se restringirán a la sustancia blanca. El efecto de incluir u omitir este paso se puede observar en la siguiente figura:
../../_images/07_ACT_Con_Sin.png

Análisis sin tractografía anatómicamente restringida (izquierda) y con tractografía anatómicamente restringida (derecha). Observe cómo, sin TCA, las líneas de corriente tienden a concentrarse en la sustancia blanca; sin embargo, una gran cantidad de ellas se encuentra en la sustancia gris y el líquido cefalorraquídeo. El uso de TCA (derecha) restringe las líneas de corriente a los tractos de sustancia blanca que se analizarán.

La tractografía anatómicamente restringida no es un paso de preprocesamiento separado, sino más bien una opción que puede incluirse con el comando tckgen, que genera las líneas de corriente reales.
Generando líneas de corriente con tckgen

MRtrix permite realizar tractografía determinista y probabilística . En la tractografía determinista, la dirección de la línea de corriente en cada vóxel se determina en función de la orientación predominante de la fibra; es decir, la línea de corriente se determina mediante un único parámetro. MRtrix incluye múltiples opciones para realizar este tipo de tractografía determinista, como FACTo tensor_det.

El otro método, la tractografía probabilística, es el predeterminado en MRtrix. En este enfoque, se generan múltiples líneas de corriente a partir de regiones semilla a lo largo del límite entre la materia gris y la materia blanca. La dirección de la línea de corriente probablemente seguirá la densidad de orientación de fibra predominante, pero no siempre; debido al gran número de muestras, algunas líneas de corriente seguirán otras direcciones. Esto es menos probable si el FOD es extremadamente intenso en una dirección; por ejemplo, los FOD dentro de una estructura como el cuerpo calloso tenderán a estar alineados de izquierda a derecha. Sin embargo, el muestreo se diversifica en regiones sin una orientación de fibra predominante.

El método predeterminado es usar un algoritmo conocido como iFOD2, que utiliza un enfoque probabilístico de línea de flujo. Se pueden encontrar otros algoritmos en este sitio , aunque en el resto del tutorial usaremos el algoritmo predeterminado de iFOD2.
¿Cuántas líneas de corriente?

Existe un equilibrio entre la cantidad de líneas de corriente generadas y el tiempo que requiere. Un mayor número de líneas de corriente resulta en una reconstrucción más precisa de los tractos de sustancia blanca subyacentes, pero estimar un gran número de ellas puede llevar un tiempo prohibitivo.

El número “correcto” de líneas de transmisión a utilizar aún se debate, pero al menos unos 10 millones deberían ser un buen punto de partida:

tckgen -act 5tt_coreg.mif -backtrack -seed_gmwmi gmwmSeed_coreg.mif -nthreads 8 -maxlength 250 -cutoff 0.06 -select 10000000 wmfod_norm.mif tracks_10M.tck

En este comando, la opción "-act" especifica que usaremos la imagen segmentada anatómicamente para restringir nuestro análisis a la sustancia blanca. "-backtrack" indica que la línea de corriente actual debe retroceder y repetirse si termina en un lugar extraño (p. ej., el líquido cefalorraquídeo); "-maxlength" establece la longitud máxima del tracto, en vóxeles, que se permitirá; y "-cutoff" especifica la amplitud del FOD para terminar un tracto (por ejemplo, un valor de 0,06 no permitiría que una línea de corriente siga un FOD inferior a ese número). "-seed_gmwmi" toma como entrada el límite entre la materia gris y la materia blanca generado con el 5tt2gmwmicomando.

"-nthreads" especifica el número de núcleos de procesamiento que desea utilizar para acelerar el análisis. Finalmente, "-select" indica cuántas líneas de flujo totales generar. Tenga en cuenta que puede usar una abreviatura si lo desea; en lugar de, por ejemplo, 10000000, puede reescribirlo como 10000k (que significa "diez mil millardos", lo que equivale a "diez millones"). Los dos últimos argumentos especifican tanto la entrada ( wmfod_norm.mif) como una etiqueta para la salida ( tracks_10M.tck).

Si desea visualizar la salida, recomiendo extraer un subconjunto de la salida mediante tckedit:

tckedit tracks_10M.tck -number 200k smallerTracks_200k.tck

Esto luego se puede cargar mrviewusando la opción “-tractography.load”, que superpondrá automáticamente el archivo lowestTracks_200k.tck sobre la imagen preprocesada ponderada por difusión:

mrview sub-02_den_preproc_unbiased.mif -tractography.load smallerTracks_200k.tck

Esto generará una figura como la siguiente:
../../_images/07_Líneas_de_flujo_cribadas.png

Recuerde inspeccionar esta imagen para asegurarse de que las líneas de corriente terminen donde cree que deberían; es decir, que estén limitadas a la sustancia blanca y que su color sea el adecuado. Por ejemplo, el cuerpo calloso debe ser mayoritariamente rojo y la corona radiada, mayoritariamente azul.

Aunque hemos creado una imagen de difusión con líneas de corriente razonables, también conocida como tractograma , aún tenemos un problema con algunos tractos de sustancia blanca sobreajustados y otros infraajustados. Esto se puede solucionar con el tcksift2comando.
Refinando las líneas de corriente con tcksift2

Podría preguntarse por qué es necesario modificar aún más las líneas de corriente una vez creado el tractograma. La razón es que algunos tractos se entrelazarán con más líneas de corriente que otros, ya que las densidades de orientación de las fibras son candidatas mucho más claras y atractivas para el algoritmo de muestreo probabilístico mencionado anteriormente. En otras palabras, ciertos tractos pueden estar sobrerrepresentados por la cantidad de líneas de corriente que los atraviesan, no necesariamente porque contengan más fibras, sino porque estas tienden a estar todas orientadas en la misma dirección.

Para contrarrestar este sobreajuste, el comando tcksift2creará un archivo de texto que contiene pesos para cada vóxel en el cerebro:

tcksift2 -act 5tt_coreg.mif -out_mu sift_mu.txt -out_coeffs sift_coeffs.txt -nthreads 8 tracks_10M.tck wmfod_norm.mif sift_1M.txt

La salida del comando "sift_1M.txt" se puede usar con el comando tck2connectomepara crear una matriz que muestre el grado de conexión de cada ROI con las demás ROI del cerebro (una cifra conocida como conectoma ), la cual ponderará cada ROI. Para ver cómo hacerlo, haga clic en el Nextbotón.
Video

Para ver una descripción general en video de las líneas de corriente y cómo adaptarlas con tckgen, haga clic aquí .

-----------------------------------------------------------------------------------------------

Tutorial n.° 8 de MRtrix: Creación y visualización del conectoma
Descripción general

Ahora que hemos creado un mapa de líneas de corriente, podemos crear un conectoma que represente el número de líneas de corriente que conectan las diferentes partes del cerebro. Para ello, primero debemos parcelar el cerebro en diferentes regiones o nodos. Una forma de hacerlo es mediante un atlas , que asigna cada vóxel del cerebro a una ROI específica.

Puedes usar cualquier atlas que quieras, pero para este tutorial usaremos los que vienen con FreeSurfer . Por lo tanto, nuestro primer paso será procesar la imagen anatómica del sujeto con recon-all, sobre lo cual puedes leer más aquí :

recon-all -i ../anat/sub-CON02_ses-preop_T1w.nii.gz -s sub-CON02_recon -all

Esto tardará unas horas, dependiendo de la velocidad de su ordenador. Una vez finalizado, asegúrese de comprobar el resultado mediante los procedimientos de control de calidad descritos en este capítulo .
Creando el Conectoma

Una vez finalizada la recon-all, necesitaremos convertir las etiquetas de la parcelación de FreeSurfer a un formato que MRtrix entienda. El comando labelconvertutilizará la salida de parcelación y segmentación de FreeSurfer para crear un nuevo archivo parcelado en formato .mif:

labelconvert sub-CON02_recon/mri/aparc+aseg.mgz $FREESURFER_HOME/FreeSurferColorLUT.txt /usr/local/mrtrix3/share/mrtrix3/labelconvert/fs_default.txt sub-CON02_parcels.mif

Luego, necesitamos crear un conectoma de cerebro completo, que represente las líneas de corriente entre cada par de parcelaciones en el atlas (en este caso, 84x84). La opción "simétrica" ​​hará que la diagonal inferior sea igual a la diagonal superior, y la opción "scale_invnodevol" escalará el conectoma según el inverso del tamaño del nodo:

tck2connectome -symmetric -zero_diagonal -scale_invnodevol -tck_weights_in sift_1M.txt tracks_10M.tck sub-CON02_parcels.mif sub-CON02_parcels.csv -out_assignment assignments_sub-CON02_parcels.csv

Visualización del conectoma

Una vez creado el parcels.csvarchivo, puede visualizarlo como una matriz en Matlab. Primero, deberá importarlo:

connectome = importdata('sub-CON02_parcels.csv');

Y luego tendrás que verlo como una imagen a escala, para que los pares de mayor conectividad estructural sean más brillantes:

imagesc(connectome)

Deberías ver una imagen como ésta:
../../_images/08_ViewingConnectome.png

La característica más notable es la división de la figura en dos "cuadros" distintos, que representan una mayor conectividad estructural dentro de cada hemisferio. También se observará una línea relativamente más brillante trazada a lo largo de la diagonal, que representa una mayor conectividad estructural entre los nodos cercanos. Los cuadros más brillantes en las esquinas opuestas inferior izquierda y superior derecha representan una mayor conectividad estructural entre regiones homólogas.

Para que estas asociaciones sean más obvias, puedes cambiar la escala del mapa de colores:

imagesc(connectome, [0 1])

../../_images/08_ViewingConnectome_Scaled.png
Video

Para ver una descripción general en video sobre cómo crear el conectoma, haga clic aquí .
Próximos pasos

Ahora que hemos preprocesado un solo sujeto y creado un conectoma, tendremos que repetir el proceso para todos los sujetos restantes. Para ello, tendremos que programar los análisis para todo nuestro conjunto de datos, lo cual haremos en el siguiente capítulo.

-----------------------------------------------------------------------------------------------------

Tutorial n.° 9 de MRtrix: Creación de scripts

Nota

Esta sección aún está en construcción; ¡vuelva pronto!
Descripción general

Después de preprocesar y configurar un modelo para una sola ejecución con un solo sujeto, deberá realizar los mismos pasos para todas las ejecuciones de todos los sujetos de su conjunto de datos. Esto puede parecer tedioso, pero es factible: solo contamos con cuarenta y dos sujetos y una ejecución de datos de difusión por sujeto. Quizás piense que puede completarse en aproximadamente una semana; y siempre puede asignar la tarea a un par de asistentes de investigación.

Esta actitud es admirable, y si adoptas este enfoque, eventualmente podrás analizar todos los datos. Pero en algún momento te encontrarás con dos problemas:

    Descubrirá que analizar manualmente cada ejecución no solo es tedioso sino también propenso a errores, y la probabilidad de cometer un error aumenta significativamente a medida que aumenta el número de ejecuciones a analizar también; y

    Para conjuntos de datos más grandes (por ejemplo, ochenta sujetos con cinco ejecuciones cada uno), este enfoque rápidamente se vuelve impráctico.

Una alternativa es guionizar el análisis. Así como un actor tiene un guion que le dice qué decir, dónde pararse y dónde moverse, también puedes escribir un guion que le indique a tu computadora cómo analizar tus conjuntos de datos. Esto tiene la doble ventaja de automatizar los análisis y permitir analizar conjuntos de datos de cualquier tamaño: el código para analizar dos o doscientos sujetos es prácticamente idéntico.

Primero, crearemos una plantilla que contiene el código necesario para analizar una sola ejecución y, a continuación, usaremos un bucle for para automatizar el análisis de todas las ejecuciones. La idea es sencilla; y aunque el código puede ser difícil de entender al principio, una vez que se familiarice con él, verá cómo puede aplicarlo a cualquier conjunto de datos.

Nota

El siguiente tutorial complementa el tutorial de Unix sobre la automatización del análisis . Recomiendo leer este capítulo si necesita repasar la terminología de Unix para scripting.
Creando la plantilla

La forma más sencilla de programar nuestro análisis sería copiar y pegar todos nuestros comandos en un archivo de texto y ejecutarlo desde la línea de comandos. Esto es básicamente lo que haremos; el único cambio será incluir argumentos que el usuario pueda completar con los archivos necesarios. Luego, podemos ejecutar esto en un bucle para todos los sujetos de nuestro conjunto de datos.

Por ahora, haremos esto para un solo sujeto. Los guiones se escribirán en cuatro partes:

    El primer script realizará todo el preprocesamiento, desde la eliminación de ruido hasta tcksift2;

    El segundo script realizará comprobaciones de control de calidad para cada una de las principales salidas de preprocesamiento;

    El tercer script preprocesará las imágenes estructurales utilizando recon-all; y

    El último script creará el conectoma.

recon-allno es parte del pipeline de MRtrix per se (puede usar cualquier atlas que desee y no está restringido a FreeSurfer), pero lo incluiremos como un prerrequisito para crear el conectoma.

Nota

Antes de continuar, descargue el script de preprocesamiento aquí . Puede descargarlo usando gito haciendo clic en Raw, haciendo clic derecho en cualquier parte de la pantalla resultante y seleccionando "Guardar como". Guárdelo en el directorio sub-CON03/ses-preop/dwi. Las siguientes secciones explicarán la función de cada bloque de código.
Guión 1: Preprocesamiento

El primer script comienza con bashcódigo, que genera un breve manual de ayuda si no se proporcionan los argumentos necesarios. Por ejemplo, el bloque de código al principio del script se ve así:

display_usage() {
  echo "$(basename $0) [Raw Diffusion] [RevPhaseImage] [AP bvec] [AP bval] [PA bvec] [PA bval] [Anatomical]"
  echo "This script uses MRtrix to analyze diffusion data. It requires 7 arguments:
    1) The raw diffusion image;
    2) The image acquired with the reverse phase-encoding direction;
    3) The bvec file for the data acquired in the AP direction;
    4) The bval file for the data acquired in the AP direction;
    5) The bvec file for the data acquired in the PA direction;
    6) The bval file for the data acquired in the PA direction;
    7) The anatomical image"
  }

  if [ $# -le 6 ]
  then
    display_usage
    exit 1
  fi

RAW_DWI=$1
REV_PHASE=$2
AP_BVEC=$3
AP_BVAL=$4
PA_BVEC=$5
PA_BVAL=$6
ANAT=$7

Estos últimos campos, marcados con los números del 1 al 7 precedidos por un signo de dólar ( $), son los argumentos que se pasan al script. Deberá introducir los argumentos en el orden exacto en que aparecen; por ejemplo, el comando que usaremos es el siguiente:

bash 01_MRtrix_Preproc_AP_Direction.sh sub-CON03_ses-preop_acq-AP_dwi.nii.gz sub-CON03_ses-preop_acq-PA_dwi.nii.gz \
sub-CON03_ses-preop_acq-AP_dwi.bvec sub-CON03_ses-preop_acq-AP_dwi.bval \
sub-CON03_ses-preop_acq-PA_dwi.bvec sub-CON03_ses-preop_acq-PA_dwi.bval \
../anat/sub-CON03_ses-preop_T1w.nii.gz

Los dos primeros argumentos especifican las imágenes con codificación de fase primaria e inversa; los cuatro argumentos siguientes apuntan a los archivos .bvec y .bval de las imágenes con codificación de fase primaria e inversa, respectivamente; y el último argumento es la imagen anatómica. Estos argumentos rellenarán las variables del resto del script, que es básicamente una compilación de todos los comandos que usamos en los capítulos anteriores. Por ejemplo, la variable $RAW_DWIse reemplazará con el primer argumento que proporcionamos, sub-CON03_ses-preop_acq-AP_dwi.nii.gz.

Copia y pega este comando en tu terminal y pulsa Intro. Mientras se ejecuta, puedes leer el resto del script de preprocesamiento (reproducido aquí para mayor claridad); revísalo para ver cómo se colocan las variables y cómo se ejecutará cada comando al ejecutar el script completo:

########################### STEP 1 ###################################
#             Convert data to .mif format and denoise                        #
######################################################################

# Also consider doing Gibbs denoising (using mrdegibbs). Check your diffusion data for ringing artifacts before deciding whether to use it
mrconvert $RAW_DWI raw_dwi.mif -fslgrad $AP_BVEC $AP_BVAL
dwidenoise raw_dwi.mif dwi_den.mif -noise noise.mif

# Extract the b0 images from the diffusion data acquired in the AP direction
dwiextract dwi_den.mif - -bzero | mrmath - mean mean_b0_AP.mif -axis 3

# Extracts the b0 images for diffusion data acquired in the PA direction
# The term "fieldmap" is taken from the output from Michigan's fMRI Lab; it is not an actual fieldmap, but rather a collection of b0 images with both PA and AP phase encoding
# For the PA_BVEC and PA_BVAL files, they should be in the follwing format (assuming you extract only one volume):
# PA_BVEC: 0 0 0
# PA_BVAL: 0
mrconvert $FIELDMAP PA.mif # If the PA map contains only 1 image, you will need to add the option "-coord 3 0"
mrconvert PA.mif -fslgrad $PA_BVEC $PA_BVAL - | mrmath - mean mean_b0_PA.mif -axis 3

# Concatenates the b0 images from AP and PA directions to create a paired b0 image
mrcat mean_b0_AP.mif mean_b0_PA.mif -axis 3 b0_pair.mif

# Runs the dwipreproc command, which is a wrapper for eddy and topup. This step takes about 2 hours on an iMac desktop with 8 cores
dwifslpreproc dwi_den.mif dwi_den_preproc.mif -nocleanup -pe_dir AP -rpe_pair -se_epi b0_pair.mif -eddy_options " --slm=linear --data_is_shelled"

# Performs bias field correction. Needs ANTs to be installed in order to use the "ants" option (use "fsl" otherwise)
dwibiascorrect ants dwi_den_preproc.mif dwi_den_preproc_unbiased.mif -bias bias.mif

# Create a mask for future processing steps
dwi2mask dwi_den_preproc_unbiased.mif mask.mif

########################### STEP 2 ###################################
#             Basis function for each tissue type                    #
######################################################################

# Create a basis function from the subject's DWI data. The "dhollander" function is best used for multi-shell acquisitions; it will estimate different basis functions for each tissue type. For single-shell acquisition, use the "tournier" function instead
dwi2response dhollander dwi_den_preproc_unbiased.mif wm.txt gm.txt csf.txt -voxels voxels.mif

# Performs multishell-multitissue constrained spherical deconvolution, using the basis functions estimated above
dwi2fod msmt_csd dwi_den_preproc_unbiased.mif -mask mask.mif wm.txt wmfod.mif gm.txt gmfod.mif csf.txt csffod.mif

# Creates an image of the fiber orientation densities overlaid onto the estimated tissues (Blue=WM; Green=GM; Red=CSF)
# You should see FOD's mostly within the white matter. These can be viewed later with the command "mrview vf.mif -odf.load_sh wmfod.mif"
mrconvert -coord 3 0 wmfod.mif - | mrcat csffod.mif gmfod.mif - vf.mif

# Now normalize the FODs to enable comparison between subjects
mtnormalise wmfod.mif wmfod_norm.mif gmfod.mif gmfod_norm.mif csffod.mif csffod_norm.mif -mask mask.mif


########################### STEP 3 ###################################
#            Create a GM/WM boundary for seed analysis               #
######################################################################

# Convert the anatomical image to .mif format, and then extract all five tissue catagories (1=GM; 2=Subcortical GM; 3=WM; 4=CSF; 5=Pathological tissue)
mrconvert $ANAT anat.mif
5ttgen fsl anat.mif 5tt_nocoreg.mif

# The following series of commands will take the average of the b0 images (which have the best contrast), convert them and the 5tt image to NIFTI format, and use it for coregistration.
dwiextract dwi_den_preproc_unbiased.mif - -bzero | mrmath - mean mean_b0_processed.mif -axis 3
mrconvert mean_b0_processed.mif mean_b0_processed.nii.gz
mrconvert 5tt_nocoreg.mif 5tt_nocoreg.nii.gz

# Uses FSL commands fslroi and flirt to create a transformation matrix for regisitration between the tissue map and the b0 images
fslroi 5tt_nocoreg.nii.gz 5tt_vol0.nii.gz 0 1 #Extract the first volume of the 5tt dataset (since flirt can only use 3D images, not 4D images)
flirt -in mean_b0_processed.nii.gz -ref 5tt_vol0.nii.gz -interp nearestneighbour -dof 6 -omat diff2struct_fsl.mat
transformconvert diff2struct_fsl.mat mean_b0_processed.nii.gz 5tt_nocoreg.nii.gz flirt_import diff2struct_mrtrix.txt
mrtransform 5tt_nocoreg.mif -linear diff2struct_mrtrix.txt -inverse 5tt_coreg.mif

#Create a seed region along the GM/WM boundary
5tt2gmwmi 5tt_coreg.mif gmwmSeed_coreg.mif

########################### STEP 4 ###################################
#                 Run the streamline analysis                        #
######################################################################

# Create streamlines
# Note that the "right" number of streamlines is still up for debate. Last I read from the MRtrix documentation,
# They recommend about 100 million tracks. Here I use 10 million, if only to save time. Read their papers and then make a decision
tckgen -act 5tt_coreg.mif -backtrack -seed_gmwmi gmwmSeed_coreg.mif -nthreads 8 -maxlength 250 -cutoff 0.06 -select 10000000 wmfod_norm.mif tracks_10M.tck

# Extract a subset of tracks (here, 200 thousand) for ease of visualization
tckedit tracks_10M.tck -number 200k smallerTracks_200k.tck

# Reduce the number of streamlines with tcksift
tcksift2 -act 5tt_coreg.mif -out_mu sift_mu.txt -out_coeffs sift_coeffs.txt -nthreads 8 tracks_10M.tck wmfod_norm.mif sift_1M.txt

Guión 2: Controles de calidad

Al igual que el script de preprocesamiento, el script de control de calidad contiene todas las comprobaciones de calidad realizadas en los capítulos anteriores. Puede descargarlo aquí y ejecutarlo escribiendo [nombre del archivo]. (Asegúrese de que esté en la carpeta antes de ejecutarlo). Utilizará [nombre del archivo] y [nombre del archivo] para examinar el resultado de cada paso del preprocesamiento, de forma similar a lo que hicimos en un capítulo anterior donde examinamos los resultados del preprocesamiento. Para continuar con la siguiente comprobación de control de calidad, deberá cerrar la ventana abierta. El contenido del script se reproduce a continuación:bash 02_QC_mrview.shsub-CON03/ses-preop/dwimrviewshview

#!/bin/bash

# These commands are for quality-checking your diffusion data


### Quality checks for Step 2 ###

# Views the voxels used for FOD estimation
echo "Now viewing the voxels used for FOD estimation (Blue=WM; Green=GM; Red=CSF)"
mrview dwi_den_preproc_unbiased.mif -overlay.load voxels.mif

# Views the response functions for each tissue type. The WM function should flatten out at higher b-values, while the other tissues should remain spherical
echo "Now viewing response function for white matter (press right arrow key to view response function for different shells)"
shview wm.txt
echo "Now viewing response function for grey matter"
shview gm.txt
echo "Now viewing response function for CSF"
shview csf.txt

# Views the FODs overlaid on the tissue types (Blue=WM; Green=GM; Red=CSF)
mrview vf.mif -odf.load_sh wmfod.mif


### Quality checks for Step 3 ###

# Check alignment of the 5 tissue types before and after alignment (new alignment in red, old alignment in blue)
mrview dwi_den_preproc_unbiased.mif -overlay.load 5tt_nocoreg.mif -overlay.colourmap 2 -overlay.load 5tt_coreg.mif -overlay.colourmap 1

# Check the seed region (should match up along the GM/WM boundary)
mrview dwi_den_preproc_unbiased.mif -overlay.load gmwmSeed_coreg.mif


### Quality checks for Step 4 ###

# View the tracks in mrview
mrview dwi_den_preproc_unbiased.mif -tractography.load smallerTracks_200k.tck

Guión 3: Reconocimiento total

El script de FreeSurfer no es un archivo de texto independiente, sino simplemente dos líneas de código. Si quieres saber más sobre la función de estos comandos, puedes consultar el tutorial de FreeSurfer :

SUBJECTS_DIR=`pwd`;
recon-all -i ../anat/sub-CON03_ses-preop_T1w.nii.gz -s sub-CON03_recon -all

En el cual sub-CON03se puede reemplazar con el objeto que se desee analizar. (Más adelante, aprenderemos cómo reemplazar esto en un bucle for). Una vez finalizado el recon-all, lo cual puede tardar varias horas, estará listo para ejecutar el último script.
Guión 4: Creación del conectoma

Crear el conectoma solo requiere unas pocas líneas de código. Para este tutorial, como se mencionó anteriormente, utilizaremos el atlas Desikan-Killiany de FreeSurfer :

#!/bin/bash

SUBJ=$1

#Convert the labels of the FreeSurfer parcellation to a format that MRtrix understands. This requires recon-all to have been run on the subject
labelconvert ${SUBJ}_recon/mri/aparc+aseg.mgz $FREESURFER_HOME/FreeSurferColorLUT.txt /usr/local/mrtrix3/share/mrtrix3/labelconvert/fs_default.txt ${SUBJ}_parcels.mif

mrtransform ${SUBJ}_parcels.mif -interp nearest -linear diff2struct_mrtrix.txt -inverse -datatype uint32 ${SUBJ}_parcels_coreg.mif

#Create a whole-brain connectome, representing the streamlines between each parcellation pair in the atlas (in this case, 84x84). The "symmetric" option will make the lower diagonal the same as the upper diagonal, and the "scale_invnodevol" option will scale the connectome by the inverse of the size of the node
tck2connectome -symmetric -zero_diagonal -scale_invnodevol -tck_weights_in sift_1M.txt tracks_10M.tck ${SUBJ}_parcels_coreg.mif ${SUBJ}_parcels_coreg.csv -out_assignment assignments_${SUBJ}_parcels_coreg.csv

Este script se puede descargar aquí . Cópielo en la carpeta sub-CON03/ses-preop/dwiy ejecútelo escribiendo:

bash 03_MRtrix_CreateConnectome.sh sub-CON03

Esto creará un archivo .csv que luego podrás ver en Matlab, tal como lo hicimos en el capítulo anterior.
Ejecución de los scripts

Recomiendo ejecutar cada script por separado para comprobar el resultado de cada parte, aunque quizás prefiera combinar todo en un único script maestro. En cualquier caso, una vez descargados todos los scripts y guardados en la BTC_preopcarpeta, puede ejecutar el siguiente bucle for para ejecutar el preprocesamiento de los sujetos 04-08 del grupo de control y 02-08 del grupo de pacientes (NOTA: Por ahora, omita CON05 y CON06, ya que ya los he creado).

for sub in sub-CON04 sub-CON05 sub-CON06 sub-CON07 sub-CON08 sub-PAT02 sub-PAT03 sub-PAT05 sub-PAT06 sub-PAT07 sub-PAT08; do
  cp *.sh ${sub}/ses-preop/dwi;
  cd ${sub}/ses-preop/dwi;
  bash 01_MRtrix_Preproc_AP_Direction.sh ${sub}_ses-preop_acq-AP_dwi.nii.gz ${sub}_ses-preop_acq-PA_dwi.nii.gz \
  ${sub}_ses-preop_acq-AP_dwi.bvec ${sub}_ses-preop_acq-AP_dwi.bval \
  ${sub}_ses-preop_acq-PA_dwi.bvec ${sub}_ses-preop_acq-PA_dwi.bval \
  ../anat/${sub}_ses-preop_T1w.nii.gz
  cd ../../..;
done

Cuando esto haya terminado, utilice el mismo bucle para ejecutar las comprobaciones de control de calidad, que se analizaron en un capítulo anterior:

for sub in sub-CON04 sub-CON05 sub-CON06 sub-CON07 sub-CON08 sub-PAT02 sub-PAT03 sub-PAT05 sub-PAT06 sub-PAT07 sub-PAT08; do
  cd ${sub}/ses-preop/dwi;
  bash 02_QC_mrview.sh;
  cd ../../..;
done

Dado que el comando tck2connectomerequiere la salida de recon-all, lo ejecutaremos en un bucle separado:

for sub in sub-CON04 sub-CON05 sub-CON06 sub-CON07 sub-CON08 sub-PAT02 sub-PAT03 sub-PAT05 sub-PAT06 sub-PAT07 sub-PAT08; do
  cd ${sub}/ses-preop/dwi;
  SUBJECTS_DIR=`pwd`;
  recon-all -i ../anat/${sub}_ses-preop_T1w.nii.gz -s ${sub}_recon -all
  cd ../../..;
done

Por último ejecutaremos el tck2connectomecomando:

for sub in sub-CON04 sub-CON05 sub-CON06 sub-CON07 sub-CON08 sub-PAT02 sub-PAT03 sub-PAT05 sub-PAT06 sub-PAT07 sub-PAT08; do
  cd ${sub}/ses-preop/dwi;
  bash 03_MRtrix_CreateConnectome.sh $sub
  cd ../../..;
done

Próximos pasos

Una vez preprocesados ​​los sujetos y realizadas las comprobaciones de calidad, podemos realizar un análisis de grupo para comparar las líneas de flujo entre el grupo de control y el grupo de pacientes. Para ver cómo hacerlo, haga clic en el Nextbotón.


-------------------------------------------------------------------------------------------------

Tutorial n.° 10 de MRtrix: Análisis a nivel de grupo

Nota

Esta sección aún está en construcción. ¡Vuelve pronto!




