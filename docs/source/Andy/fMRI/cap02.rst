
Capítulo 2: La GUI de FEAT y la carga de datos funcionales
===========================================================

https://andysbrainbook-readthedocs-io.translate.goog/en/latest/fMRI_Short_Course/Preprocessing/FEAT_GUI.html?_x_tr_sl=en&_x_tr_tl=es&_x_tr_hl=es&_x_tr_pto=tc


El resto de los pasos de preprocesamiento (corrección de movimiento mediante normalización) se realizarán en la interfaz gráfica de FEAT. El botón FEAT se encuentra en el centro del menú de la interfaz gráfica de FSL; al hacer clic en él, se abrirá una ventana con varias pestañas.
../../_images/FEAT_GUI.png

Al hacer clic en el botón de análisis FEAT FMRI (A), se abre la interfaz gráfica de usuario de FEAT. Por ahora, nos centraremos en las pestañas Data, Pre-statsy Registration, que preprocesan los datos. En el menú desplegable superior derecho (B), seleccione Preprocessing. Esto desactivará las pestañas Estadísticas y Posestadísticas, lo que nos permitirá centrarnos únicamente en el preprocesamiento. Haga clic en el botón (C) para cargar los datos de imágenes (en este ejemplo, , que se encuentra en el directorio). Se abrirá una nueva ventana (D), con un icono de carpeta que permite seleccionar una ejecución de imágenes funcionales (E).Select 4D datasub-08_task-flanker_run-1_bold.nii.gzfunc

Al cargar una imagen funcional, FSL lee la información de su encabezado . Imagine la imagen como una matriz tridimensional de números, donde los números más altos se representan con mayor brillo que los más bajos. Este contraste permite distinguir diferentes estructuras dentro de la imagen. El encabezado, por otro lado, contiene información que no se ve directamente en la imagen, pero que es necesaria para su visualización, por ejemplo, la orientación. El encabezado de datos tetradimensionales (es decir, conjuntos de datos individuales que contienen varios volúmenes) también contiene números que indican el TR y el número de volúmenes.

Después de cargar los datos de entrada, estos campos se ingresarán automáticamente en los campos correspondientes de la GUI de FEAT, como se muestra en el siguiente video:
../../_images/FEAT_GUI_Demonstration.gif

Asegúrese de verificar que el TR y el número de volúmenes coincidan con los adquiridos en el escáner. Si tiene alguna pregunta sobre los parámetros utilizados, consulte a su técnico de escaneo.

Las dos pestañas siguientes, Preestadísticas y Registro, se analizarán en los siguientes capítulos. Para continuar con el tutorial sobre los pasos de preprocesamiento, haga clic en el botón Siguiente.

Capítulo 3: Corrección de movimiento

Si alguna vez has intentado fotografiar un objeto en movimiento, la imagen suele salir borrosa. En cambio, si el objeto está inmóvil, obtendrás una imagen mucho más clara y nítida.
../../_images/Movimiento_de_mano.png

Un objetivo en movimiento produce una imagen borrosa (izquierda), mientras que un objetivo estacionario produce una imagen más claramente definida (derecha).

El concepto es el mismo al tomar imágenes tridimensionales del cerebro. Si el sujeto se mueve, las imágenes se verán borrosas; si está inmóvil, se verán más definidas. Pero eso no es todo: si el sujeto se mueve mucho, también corremos el riesgo de medir la señal de un vóxel que se mueve. En ese caso, corremos el riesgo de medir la señal del vóxel durante parte del experimento y, después de que el sujeto se mueva, de una región o tipo de tejido diferente.

Por último, el movimiento puede introducir confusiones en los datos de imagen, ya que genera señales. Si el sujeto se mueve constantemente en respuesta a un estímulo (por ejemplo, si sacude la cabeza cada vez que siente una descarga eléctrica), puede resultar imposible determinar si la señal que medimos responde al estímulo o se debe al movimiento.

Una forma de "deshacer" estos movimientos es mediante transformaciones de cuerpo rígido . Para ilustrarlo, tome un objeto cercano: un teléfono o una taza de café, por ejemplo. Colóquelo frente a usted y marque mentalmente dónde está. Este es el punto de referencia . Luego mueva el objeto una pulgada a la izquierda. Esto se llama traslación , que significa cualquier movimiento hacia la izquierda o la derecha, hacia adelante o hacia atrás, hacia arriba o hacia abajo. Si desea que el objeto regrese a donde comenzó, simplemente muévalo una pulgada a la derecha.

De forma similar, si rotaste el objeto a la izquierda o a la derecha, podrías deshacerlo girándolo la misma cantidad en la dirección opuesta. Estas rotaciones se llaman rotaciones y, al igual que las traslaciones, tienen tres grados de libertad o formas de movimiento: alrededor del eje x (también llamado cabeceo , o inclinación hacia adelante y hacia atrás), alrededor del eje y (también conocido como balanceo , o inclinación a la izquierda y a la derecha) y alrededor del eje z (o guiñada , como al negar con la cabeza).

Nota

Experimenta con estas traslaciones y rotaciones moviendo la cabeza. Primero, mueve la cabeza de lado a lado mientras miras al frente (traslación a lo largo del eje x). Luego, mueve la cabeza hacia adelante y hacia atrás (eje y) y hacia arriba y hacia abajo (eje z). Prueba también las rotaciones.

Realizamos el mismo procedimiento con nuestros volúmenes. En lugar del punto de referencia que usamos en el ejemplo anterior, llamaremos volumen de referencia al primer volumen de nuestra serie temporal . Si en algún momento del escaneo nuestro sujeto mueve la cabeza unos centímetros a la derecha, podemos detectar ese movimiento y corregirlo moviendo ese volumen unos centímetros a la izquierda. El objetivo es detectar movimientos en cualquiera de los volúmenes y realinearlos con el volumen de referencia.
../../_images/EjemploDeCorrecciónDeMovimiento.gif

El volumen de referencia puede ser cualquier volumen de la serie temporal (aunque normalmente es el primero, el intermedio o el último). Si durante la exploración el sujeto se mueve hacia la derecha, ese movimiento puede revertirse con respecto al volumen de referencia mediante un movimiento igual y opuesto hacia la izquierda.

En la interfaz gráfica de FEAT, la corrección de movimiento se especifica en la Pre-statspestaña. FEAT usa por defecto la herramienta MCFLIRT de FSL, que se encuentra en el menú desplegable. Tiene la opción de desactivar la corrección de movimiento, pero a menos que tenga una razón para hacerlo, déjela como está.
../../_images/FEAT_MCFLIRT.png

La pestaña Preestadísticas contiene otras opciones de preprocesamiento, como la corrección de la temporización de corte y el suavizado. Para obtener una descripción general de la corrección de la temporización de corte, haga clic en el botón Siguiente.


Capítulo 4: Corrección de la sincronización de segmentos

A diferencia de una fotografía, donde la imagen completa se toma en un solo instante, el volumen de fMRI se adquiere en cortes . Cada uno de estos cortes tarda en adquirirse, desde decenas hasta cientos de milisegundos.

Los dos métodos más comunes para crear volúmenes son la adquisición secuencial y la intercalada de cortes. La adquisición secuencial de cortes adquiere cada corte adyacente consecutivamente, ya sea de abajo a arriba o de arriba a abajo. La adquisición intercalada de cortes adquiere cada corte de por medio y luego rellena los espacios vacíos en la segunda pasada. Ambos métodos se ilustran en el video a continuación.
../../_images/SliceTimingCorrection_Demo.gif

Como se verá más adelante, al modelar los datos en cada vóxel, asumimos que todos los cortes se adquirieron simultáneamente. Para que esta suposición sea válida, la serie temporal de cada corte debe retrocederse en el tiempo según el tiempo que tardó en adquirirse. Sladky et al. (2011) también demostraron que la corrección temporal de los cortes puede generar aumentos significativos en la potencia estadística en estudios con TR más largos (p. ej., 2 s o más), especialmente en las regiones dorsales del cerebro.

Aunque la corrección del tiempo de corte parece razonable, existen algunas objeciones:

    En general, es mejor no interpolar (es decir, editar) los datos a menos que sea necesario;

    Para TR cortos (por ejemplo, alrededor de 1 segundo o menos), la corrección del tiempo de corte no parece conducir a ninguna ganancia significativa en potencia estadística; y

    Muchos de los problemas abordados mediante la corrección del tiempo de corte se pueden resolver utilizando una derivada temporal en el modelo estadístico (que se analiza más adelante en el capítulo sobre ajuste del modelo).

La configuración predeterminada de FSL es no aplicar corrección temporal de cortes e incluir, en su lugar, una derivada temporal. Más adelante, realizará un ejercicio comparando los datos con y sin corrección temporal de cortes para observar la magnitud de la diferencia.
../../_images/Prestats_STC.png

El último paso de preprocesamiento que abordaremos en la pestaña Preestadísticas es el Suavizado. Para saber qué es el suavizado y cómo usarlo, haga clic en el botón Siguiente.


Capítulo 5: Suavizado
¿Por qué Smooth?

Es común suavizar los datos funcionales o reemplazar la señal en cada vóxel con un promedio ponderado de sus vecinos. Esto puede parecer extraño al principio: ¿por qué querríamos que las imágenes fueran más borrosas de lo que ya son?

Es cierto que el suavizado disminuye la resolución espacial de los datos funcionales, y no buscamos una menor resolución. Sin embargo, el suavizado también ofrece ventajas que pueden compensar las desventajas. Por ejemplo, sabemos que los datos de fMRI contienen mucho ruido, y que este suele ser mayor que la señal. Al promediar sobre vóxeles cercanos, podemos cancelar el ruido y mejorar la señal.
../../_images/Demo_de_suavizado.gif

En esta animación, se aplican dos núcleos de suavizado diferentes (4 mm y 10 mm) a una resonancia magnética funcional. Observe que, al usar núcleos de suavizado más grandes, las imágenes se vuelven más borrosas y los detalles anatómicos se vuelven menos nítidos. También tenga en cuenta que, para simplificar, esta animación utiliza un corte 2D del cerebro para mostrar este paso de preprocesamiento. En datos reales de resonancia magnética funcional, el núcleo se aplicaría en las tres dimensiones.

El suavizado ofrece otra ventaja. Como verá en el siguiente capítulo, nuestro objetivo es normalizar el cerebro de cada sujeto a un cerebro modelo con coordenadas estandarizadas. Haga clic en el botón Siguiente para obtener más información sobre la normalización y cómo el suavizado puede ayudar a mejorar la potencia estadística.

------------------------------------------------------------------------------------------

Capítulo 6: Registro y normalización
Descripción general

Aunque el cerebro de la mayoría de las personas es similar (por ejemplo, todos tenemos una circunvolución cingulada y un cuerpo calloso), también existen diferencias en el tamaño y la forma cerebrales. Por lo tanto, si queremos realizar un análisis grupal, debemos asegurarnos de que cada vóxel de cada sujeto corresponda a la misma parte del cerebro. Si medimos un vóxel en la corteza visual, por ejemplo, debemos asegurarnos de que la corteza visual de cada sujeto esté alineada.

Esto se hace mediante el registro y la normalización de las imágenes. Tal como doblarías la ropa para que quepa dentro de una maleta, cada cerebro necesita ser transformado para tener el mismo tamaño, forma y dimensiones. Hacemos esto normalizando (o deformando ) a una plantilla . Una plantilla es un cerebro que tiene dimensiones y coordenadas estándar: estándar, porque la mayoría de los investigadores han acordado usarlas al informar sus resultados. De esa manera, si normalizas tus datos a esa plantilla y encuentras un efecto en las coordenadas X = 3, Y = 20, Z = 42, alguien más que haya deformado sus datos a la misma plantilla puede comparar sus resultados con los tuyos. Las dimensiones y coordenadas del cerebro plantilla también se conocen como espacio estandarizado .
../../_images/MNI_Template.png

Un ejemplo de una plantilla de uso común es el cerebro MNI152 . Se trata de un promedio de 152 cerebros adultos sanos, que representan la población de la que se extraen la mayoría de los estudios. Si está estudiando otra población, como niños o ancianos, considere usar una plantilla creada con representantes de esa población. (Pregunta: ¿Por qué está borrosa esta plantilla? Revise el capítulo anterior sobre suavizado para obtener una pista).
Transformaciones afines

Para deformar las imágenes según una plantilla, usaremos una transformación afín . Esta es similar a la transformación de cuerpo rígido descrita anteriormente en Corrección de movimiento, pero añade dos transformaciones más: zoom y corte . Mientras que las traslaciones y rotaciones son fáciles de realizar con un objeto cotidiano como un bolígrafo, los zoom y cortes son más inusuales: los zoom reducen o amplían la imagen, mientras que los cortes toman las esquinas diagonalmente opuestas de la imagen y las estiran. La animación a continuación resume estos cuatro tipos de transformaciones lineales .
../../_images/AffineTransformations.gif

Nota

Al igual que con las transformaciones de cuerpo rígido, los zoom y los cortes tienen tres grados de libertad: puede hacer zoom o cortar una imagen a lo largo del eje x, y o z. En total, entonces, las transformaciones afines tienen doce grados de libertad. Estas también se llaman transformaciones lineales porque una transformación aplicada en una dirección a lo largo de un eje está acompañada por una transformación de igual magnitud en la dirección opuesta. Una traslación de un milímetro a la izquierda, por ejemplo, implica que la imagen se ha movido un milímetro desde la derecha. Del mismo modo, si una imagen se amplía un milímetro a lo largo del eje z, se amplía un milímetro en ambas direcciones a lo largo de ese eje. Las transformaciones sin estas restricciones se llaman transformaciones no lineales . Por ejemplo, una transformación no lineal puede ampliar la imagen en una dirección mientras la encoge en la otra dirección, como cuando se aprieta una esponja. Estos tipos de transformaciones se tratarán más adelante.
Registro y Normalización

Recuerde que nuestro conjunto de datos incluye imágenes anatómicas y funcionales. Nuestro objetivo es adaptar las imágenes funcionales a la plantilla para realizar un análisis grupal de todos los sujetos. Si bien parece razonable adaptar las imágenes funcionales directamente a la plantilla, en la práctica esto no funciona bien: las imágenes tienen baja resolución y, por lo tanto, es menos probable que coincidan con los detalles anatómicos de la plantilla. La imagen anatómica es una mejor opción.

Aunque esto parezca no ayudarnos a alcanzar nuestro objetivo, de hecho, deformar la imagen anatómica puede ayudar a estandarizar las imágenes funcionales. Recuerde que las exploraciones anatómicas y funcionales suelen adquirirse en la misma sesión, y que la cabeza del sujeto se mueve poco o nada entre las exploraciones. Si ya hemos normalizado nuestra imagen anatómica a una plantilla y registrado las transformaciones realizadas, podemos aplicar las mismas transformaciones a las imágenes funcionales, siempre que comiencen en el mismo lugar que la imagen anatómica.

Esta alineación entre las imágenes funcionales y anatómicas se denomina registro . La mayoría de los algoritmos de registro utilizan los siguientes pasos:

    Suponga que las imágenes funcionales y anatómicas están prácticamente en la misma ubicación. De no ser así, alinee los contornos de las imágenes.

    Aproveche que las imágenes anatómicas y funcionales tienen diferentes ponderaciones de contraste; es decir, las áreas oscuras en la imagen anatómica (como el líquido cefalorraquídeo) aparecerán brillantes en la imagen funcional, y viceversa. Esto se denomina información mutua . El algoritmo de registro mueve las imágenes para probar diferentes superposiciones de las imágenes anatómicas y funcionales, haciendo coincidir los vóxeles brillantes de una imagen con los oscuros de otra, y los oscuros con los brillantes, hasta encontrar una coincidencia irreprochable.

    Una vez que se encuentra la mejor coincidencia, se aplican a las imágenes funcionales las mismas transformaciones que se utilizaron para deformar la imagen anatómica según la plantilla.

../../_images/Demo_de_Normalización_de_Registro.gif
Normalización, suavizado y potencia estadística

Como se leyó en la página anterior , el suavizado tiende a cancelar el ruido y mejorar la señal. Esto también aplica a los análisis de grupo, en los que todas las imágenes de los sujetos se han normalizado según una plantilla. Si bien las imágenes funcionales de cada sujeto se transformarán para que coincidan con la forma general y las características anatómicas generales de la plantilla, habrá variaciones en la alineación de las regiones anatómicas más pequeñas entre las imágenes funcionales normalizadas. Si las imágenes se suavizan, habrá mayor superposición entre los grupos de señal y, por lo tanto, mayor probabilidad de detectar un efecto significativo.
La pestaña de registro

El registro y la normalización, aunque son distintos, se integran en un solo paso en la Registrationpestaña de la interfaz gráfica de usuario de FEAT. Una vez seleccionada esta pestaña, haga clic en el botón junto a para expandir el campo de entrada. A continuación, seleccione la imagen del sujeto con el cráneo despojado; en este caso, la que creamos con un umbral de intensidad fraccionaria de 0,2.Main structural image

Observará que hay menús desplegables debajo de los campos y . Los menús del campo Imagen estructural principal corresponden a las opciones para registrar la imagen funcional con la anatómica. Los menús del campo Espacio estándar son opciones para normalizar la imagen anatómica con respecto a la imagen de plantilla. Dentro de estos conjuntos de menús, el menú desplegable de la izquierda es la ventana, y el de la derecha es la ventana.Main structural imageStandard spaceSearchDegrees of Freedom

En la Searchventana, hay tres opciones: 1) Sin búsqueda; 2) Búsqueda normal; y 3) Búsqueda completa. Esto indica a FSL el grado de búsqueda necesario para lograr una buena alineación inicial entre las imágenes funcionales y anatómicas (para el registro) y entre las imágenes anatómicas y las plantillas (para la normalización). La opción de búsqueda completa es más larga, pero más exhaustiva y, por lo tanto, más propensa a producir un mejor registro y normalización.

En la ventana, puede usar 3, 6 o 12 grados de libertad para transformar las imágenes. El registro tiene una opción adicional, , que significa Registro de Límites Cerebrales. Esta es una técnica de registro más avanzada que utiliza los límites tisulares para ajustar la alineación entre las imágenes funcionales y anatómicas. Similar a la opción de búsqueda completa mencionada anteriormente, tarda más, pero suele ofrecer una mejor alineación.Degrees of FreedomBBR

Por ahora, configure las opciones de búsqueda en Búsqueda completa y los grados de libertad en 12 grados de libertad. Si ya ha cargado sus imágenes funcionales en la pestaña Datos, haga clic en el botón Ir para ejecutar todos los pasos de preprocesamiento.
../../_images/Configuración_del_registro.gif
Video

El registro y la normalización son el último paso del proceso de preprocesamiento para un solo sujeto. Para ver un video de captura de pantalla que muestra cómo configurar todo el preprocesamiento a través de la interfaz gráfica de FEAT, haga clic aquí .

--------------------------------------------------------------------------------------


Capítulo 7: Comprobación de los datos preprocesados

Al igual que hicimos con las imágenes sin cráneo, revisaremos nuestros datos antes y después de procesarlos con la interfaz gráfica de FEAT. Al hacer clic en el Gobotón, páginas HTML como la que se muestra a continuación registrarán el progreso de cada paso.
../../_images/FEAT_HTML_Progress.png
Comprobación del registro y la normalización

Dado que solo estamos realizando preprocesamiento, solo tendremos resultados para las pestañas Registro y Preestadísticas. Haga clic en la pestaña Registro para examinar los resultados de cada paso de registro y normalización. Si se desplaza hacia abajo en la página, debería ver imágenes similares a esta:
../../_images/FEAT_Registration_Page.png

Cada imagen superpone el contorno rojo de un cerebro sobre una imagen en escala de grises de otro cerebro. El primer montaje, [ ], muestra una imagen funcional representativa (en este caso, la imagen mediana de la serie temporal de fMRI) como base, y el cerebro modelo como líneas rojas. Esta imagen se muestra primero, ya que si hubiera algún problema en alguno de los pasos previos de registro o normalización, se observarían errores obvios, como que la imagen estuviera sesgada o fuera del contorno rojo.Summary Registration

Observe si los contornos rojos se asemejan al contorno de la imagen en escala de grises. Compruebe también si algunas de las estructuras internas de las imágenes, como los ventrículos, están alineadas. Realice las mismas comprobaciones de calidad para las demás alineaciones, como el registro de la imagen funcional de ejemplo con la imagen de alta resolución (es decir, la imagen anatómica) y la normalización de esta última con la plantilla espacial estándar.
Comprobación de movimiento

Cuando termine de ver la página de Registro, haga clic en el enlace "Pre-estadísticas". Si se desplaza hacia abajo, verá gráficos del movimiento a lo largo de la serie temporal de esa ejecución, con los volúmenes indexados en el eje x y la cantidad de movimiento (en milímetros) en el eje y.
../../_images/FEAT_Prestats_Page.png

Busque picos en los gráficos de movimiento que superen la mitad de la resolución de su vóxel y desviaciones que superen el tamaño de un vóxel completo. Si hay un movimiento relativo de más de medio vóxel o un movimiento absoluto de más de un vóxel, puede considerar técnicas de corrección más avanzadas, como la depuración o la eliminación total del análisis. Por lo tanto, si adquirió un volumen con una resolución de vóxel de 3 x 3 x 3 milímetros, debería marcar cualquier ejecución con un movimiento relativo de más de 1,5 mm entre volúmenes o un movimiento absoluto de más de 3 mm en toda la ejecución. Estas son solo directrices y puede modificarlas según la población que esté estudiando.
Video

Para ver un video de captura de pantalla sobre cómo comprobar la calidad de sus datos, haga clic aquí . Este video explica con más detalle qué debe buscar exactamente en cada pestaña de preprocesamiento.

-------------------------------------------------------------------


Punto de control: preprocesamiento

Ahora es un buen momento para repasar lo que hemos hecho hasta ahora:

    Descargamos un conjunto de datos fMRI que tiene imágenes anatómicas y funcionales;

    Observamos los datos en FSLeyes, el visualizador de datos de FSL;

    Preprocesamos los datos utilizando FEAT, la herramienta de preprocesamiento de FSL.

Durante el proceso, aprendiste a revisar las imágenes antes y después de cada paso de preprocesamiento. Al aplicar los mismos controles de calidad a diferentes conjuntos de datos, te encontrarás con imágenes difíciles de evaluar; pueden parecer estar en el límite entre lo aceptable y lo inaceptable.

Al principio puede resultar confuso. Pero con el tiempo, desarrollarás tu criterio sobre qué imágenes son claramente buenas, cuáles son obviamente malas y cuáles debes considerar cuidadosamente antes de conservarlas o descartarlas. Cuanto más pienses en por qué los resultados de un preprocesamiento se ven bien o mal, más fácil te resultará tomar decisiones con mayor rapidez y precisión.

Pruebe los siguientes ejercicios para aumentar su fluidez con FSL y mejorar su juicio sobre el resultado de cada paso.
Ceremonias

    Ejecute BET en la imagen anatómica sub-08_T1w.nii.gzcon dos umbrales de intensidad fraccional: 0,1 y 0,9. Tome una instantánea de cada imagen resultante con FSLeyes usando el botón de la cámara (ubicado en la parte superior central del visor). Observe las diferencias entre ambas. ¿El resultado es el esperado? Si tuviera que usar una u otra imagen, ¿cuál elegiría?

    Preprocese la segunda ejecución de los datos funcionales mediante la interfaz gráfica de usuario de FEAT. Para ello, seleccione sub-08_task-flanker_run2.nii.gzdel funcdirectorio, cambie el directorio de salida a run2y asegúrese de Preprocessingque esté seleccionado en el menú desplegable. Mantenga los demás ajustes como en la ejecución 1. Realice las mismas comprobaciones de calidad que para la ejecución 1.

    Preprocese la primera ejecución con un kernel de suavizado de 3 mm, manteniendo las demás opciones de preprocesamiento. (Asegúrese, sin embargo, de cambiar el nombre del directorio de salida para mantener la salida organizada). Antes de examinar la salida, ejecute otro análisis con un kernel de suavizado de 12 mm. Piense en cómo esperaría que se vieran los datos funcionales preprocesados ​​y luego cargue las filtered_func_data.nii.gzimágenes de cada análisis en FSLeyes. ¿Cómo se comparan con sus predicciones?

    Ejecución 1 del preprocesamiento con 3DOFregistro y normalización. ¿En qué se diferencia el resultado del preprocesamiento con [nombre del archivo] 12DOF? ¿Por qué? (Sugerencia: Consulte la página de Registro y Normalización para conocer las posibles razones).

    Reejecutar el registro para la ejecución 1 usando BBRen lugar de 12DOF. ¿Qué diferencia hay? ¿Cómo argumentarías que deberías usar uno en lugar del otro?

Cuando haya terminado de realizar los ejercicios, haga clic en el botón Siguiente para comenzar el módulo sobre Estadística y Modelado.

Advertencia

Asegúrese de haber preprocesado ambos run1antes run2de continuar; necesitará ambos para ejecutar un análisis de nivel superior y utilizar los scripts que se proporcionan en Github .



