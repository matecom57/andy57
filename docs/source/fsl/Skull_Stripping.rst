

.. _Desnudar el cráneo:

Capítulo 1: Extracción cerebral (también conocida como "skullstripping")
==============================

--------------------

Dado que los estudios de fMRI se centran en el tejido cerebral, el primer paso es eliminar el cráneo y las áreas no cerebrales de la imagen. FSL cuenta con una herramienta para esto llamada **bet**, o Herramienta de Extracción Cerebral. Es el primer botón que aparece en la interfaz gráfica de usuario de FSL (indicado con una "A" en la figura siguiente). Al hacer clic en este botón, se abre otra ventana que permite especificar la imagen de entrada que se va a eliminar del cráneo y cómo etiquetar la imagen de salida eliminada (B), así como una subventana expandible que permite especificar opciones avanzadas (C).

.. figura:: FSL_BET_GUI.png


.. nota::
  Para BET y muchas otras herramientas FSL, es necesario especificar una imagen de entrada y una etiqueta para la imagen de salida: se realiza una operación en la imagen de entrada (por ejemplo, la eliminación de cráneos) y la imagen de salida es el resultado de dicha operación. Normalmente, las demás opciones se configuran con valores predeterminados que funcionan bien para la mayoría de los conjuntos de datos, pero se pueden anular si se desea.
  

Abra la interfaz gráfica de FSL desde el directorio ``sub-08``, haga clic en el icono de carpeta junto al campo ``Imagen de entrada`` y navegue hasta el directorio ``anat``. Seleccione el archivo ``sub-08_T1w.nii.gz`` y haga clic en el botón Aceptar. Observe que el campo ``Imagen de salida`` se completa automáticamente con la palabra ``brain`` adjunta a la imagen de entrada, que es la opción predeterminada de FSL. Puede cambiar el nombre si lo desea, pero en este tutorial lo dejaremos como está.

Ahora haz clic en el botón "Ir" en la parte inferior de la ventana. Verás un texto en tu terminal que muestra los comandos que se utilizan para ejecutar el comando "bet2". Observa cómo la interfaz gráfica de usuario (GUI) se corresponde con la terminal. Más adelante, aprovecharemos esta ventaja creando una plantilla a través de la GUI y modificándola en la terminal para preprocesar automáticamente todos los sujetos de nuestro conjunto de datos.

Mirando los datos
********

Cuando la terminal indique "Finalizado", la apuesta 2 estará lista. Dado que ha creado una nueva imagen, debería revisar sus datos, lo cual haremos después de cada paso de preprocesamiento.

.. nota::
  Los principiantes suelen escuchar la frase "Mira tus datos" como un mantra. Sin saber *cómo* mirar los datos, estas palabras pierden sentido en el mejor de los casos y, en el peor, resultan un falso consuelo. Cada paso de preprocesamiento de este capítulo irá seguido de recomendaciones sobre qué buscar y ejemplos concretos de qué es correcto y qué constituye un problema, y qué hacer al respecto. Aunque no podemos abarcar todos los ejemplos posibles, a medida que adquiera experiencia, desarrollará su criterio para distinguir qué imágenes son de buena calidad y cuáles deben corregirse o eliminarse.
  

Haz clic en el botón "FSLeyes" en la parte inferior de la interfaz gráfica. Cuando se abra, haz clic en "Archivo -> Agregar desde archivo" y mantén presionada la tecla Mayús para seleccionar tanto la imagen anatómica original como la imagen con el cráneo despojado que acabas de crear. Como viste en un capítulo anterior."Querrás cambiar el contraste para distinguir claramente la materia gris de la materia blanca.

Al cargar ambas imágenes, puede comparar la imagen antes y después de extraer el cráneo. En el panel "Lista de superposiciones", en la esquina inferior izquierda de FSLeyes, haga clic en el icono del ojo para ocultar la imagen correspondiente. Por ejemplo, si hace clic en el icono del ojo junto a "sub-08_T1w", la imagen anatómica original en T1 se volverá invisible y solo verá el cerebro sin cráneo. Si vuelve a hacer clic en el ojo, verá el T1 original. Para que las diferencias entre los cerebros sean más evidentes, resalte la imagen sin cráneo en el panel "Lista de superposiciones" y cambie el contraste de "Escala de grises" a "Azul-azul claro". La siguiente animación muestra cómo hacerlo.

.. advertencia::

  Con la versión de fsleyes de noviembre de 2019, algunos usuarios se encuentran con el siguiente mensaje de error al intentar cargar una imagen generada por cualquiera de los comandos FSL: "Error al cargar la superposición: No parece un archivo BIDS". Si recibe este mensaje de error, intente mover los archivos .json de los directorios anat y func a una carpeta independiente y vuelva a intentar cargar las imágenes.

Haga clic en la imagen con el ratón y observe dónde se extrajo demasiado cerebro o muy poco cráneo. Recuerde que intentamos crear una imagen en la que se ha eliminado completamente el cráneo y la cara, dejando solo el cerebro (por ejemplo, corteza, estructuras subcorticales, tronco encefálico y cerebelo).

.. figura:: BET_Demonstration.gif

  Demostración de cómo usar la BET para examinar la imagen anatómica antes y después de la extracción del cráneo. Observe que en la corteza frontal se ha extirpado parte del cerebro. Asegúrese de revisar los tres paneles de visualización para detectar problemas.

Arreglando una tira de cráneo defectuosa
***********

Si no está satisfecho con la extracción del cráneo, ¿qué puede hacer al respecto? Recuerde que la ventana BET contiene opciones que podemos modificar si lo desea. Uno de los campos, denominado "Umbral de intensidad fraccional", está configurado en 0,5 por defecto. El texto contiguo explica que valores más bajos dan estimaciones más altas del contorno cerebral (y, a la inversa, valores más altos dan estimaciones más bajas). En otras palabras, si consideramos que se ha extraído demasiado cerebro, debemos establecer un valor menor, y viceversa si consideramos que se ha extraído muy poco cráneo.

Dado que parece que BET ha extraído demasiado cerebro, intente reducir el umbral de intensidad fraccional a 0,2. Asegúrese también de cambiar el nombre de la salida a algo que le ayude a recordar lo que hizo; por ejemplo, ``sub-08_T1w_brain_f02``. Haga clic en el botón ``Ir`` para volver a ejecutar la extracción de cráneo.

.. figura:: BET_f02_GUI.png


Una vez finalizado, cargue la imagen más reciente del cráneo en FSLeyes. Haga clic en el icono del ojo junto a la imagen anatómica original y, a continuación, en el icono del ojo junto a la imagen más reciente que acabamos de crear. Observe dónde se ha conservado más corteza, especialmente en la corteza frontal y la corteza parietal. También habrá notado que en esta imagen aún queda más duramadre y fragmentos de cráneo. Por regla general, es mejor optar por dejar demasiado cráneo que por eliminar demasiada corteza; la presencia de fragmentos de cráneo no provocará fallos en futuros pasos de preprocesamiento (como la normalización), pero una vez eliminada la corteza, no podrá recuperarla.


--------------

Ceremonias
***********

1. Cambie el umbral de intensidad fraccional a 0,1 y vuelva a ejecutar BET, asegurándose de elegir un nombre de salida adecuado para mantener los archivos organizados. Vea el resultado en FSLeyes. Repita estos pasos con un umbral de intensidad fraccional de 0,9. ¿Qué observa? ¿Cuál parece ser un umbral adecuado?

2. Experimenta con diferentes colores de contraste para la imagen superpuesta en FSLeyes para ver cuál te gusta más. Usa el control deslizante de Zoom (junto al icono de la lupa) para enfocar una zona que creas que no se ha eliminado bien. Toma una foto del montaje (es decir, de los tres paneles de visualización) haciendo clic en el icono de la cámara en la barra de herramientas sobre el montaje.

---------

Video
*******

Para ver una captura de pantalla que muestra cómo verificar la imagen de su cráneo despojado, haga clic aquí
    `__. Esto puede ayudarte con los ejercicios anteriores.

    
   

