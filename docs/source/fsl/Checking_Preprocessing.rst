

.. _Comprobando_Preprocesamiento.rst

Capítulo 7: Comprobación de sus datos preprocesados
^^^^^^^^^^

Al igual que hicimos con las imágenes de cráneo despojado, revisaremos nuestros datos antes y después de procesarlos con la interfaz gráfica de FEAT. Tras hacer clic en el botón "Ir", páginas HTML como la que se muestra a continuación registrarán el progreso de cada paso.

.. figura:: FEAT_HTML_Progress.png


--------

Comprobación del registro y la normalización
*********

Dado que solo estamos realizando preprocesamiento, solo tendremos resultados para las pestañas Registro y Preestadísticas. Haga clic en la pestaña Registro para examinar los resultados de cada paso de registro y normalización. Si se desplaza hacia abajo en la página, debería ver imágenes similares a esta:

.. figura:: FEAT_Registration_Page.png

Cada imagen superpone el contorno rojo de un cerebro sobre una imagen en escala de grises de otro cerebro. El primer montaje, «Registro de Resumen», muestra una imagen funcional representativa (en este caso, la imagen mediana de la serie temporal de fMRI) como base, y el cerebro modelo como líneas rojas. Esta imagen se muestra primero, ya que si hubiera algún problema en alguno de los pasos previos de registro o normalización, se observarían errores obvios, como que la imagen estuviera sesgada o fuera del contorno rojo.

Observe si los contornos rojos se asemejan al contorno de la imagen en escala de grises. Compruebe también si algunas de las estructuras internas de las imágenes, como los ventrículos, están alineadas. Realice las mismas comprobaciones de calidad para las demás alineaciones, como el registro de la imagen funcional de ejemplo con la imagen de alta resolución (es decir, la imagen anatómica) y la normalización de esta última con la plantilla espacial estándar.


Comprobación de movimiento
*********

Cuando termine de ver la página de Registro, haga clic en el enlace "Pre-estadísticas". Si se desplaza hacia abajo, verá gráficos del movimiento a lo largo de la serie temporal de esa ejecución, con los volúmenes indexados en el eje x y la cantidad de movimiento (en milímetros) en el eje y.

.. figura:: FEAT_Prestats_Page.png

Busque picos en los gráficos de movimiento que superen la mitad de la resolución de su vóxel y desviaciones que superen el tamaño de un vóxel completo. Si hay un movimiento relativo de más de medio vóxel o un movimiento absoluto de más de un vóxel, puede considerar técnicas de corrección más avanzadas, como la depuración o la eliminación total del análisis. Por lo tanto, si adquirió un volumen con una resolución de vóxel de 3 x 3 x 3 milímetros, debería marcar cualquier ejecución con un movimiento relativo de más de 1,5 mm entre volúmenes o un movimiento absoluto de más de 3 mm en toda la ejecución. Estas son solo directrices y puede modificarlas según la población que esté estudiando.

-------

Video
*******

Para ver un video de captura de pantalla sobre cómo verificar la calidad de sus datos, haga clic aquí`__. Esto explicará con más detalle qué es exactamente lo que debe buscar en cada una de las pestañas de preprocesamiento.

   

