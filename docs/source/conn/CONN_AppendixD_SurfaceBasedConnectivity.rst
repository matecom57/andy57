

.. _CONN_ApéndiceD_Conectividad basada en superficie:

======================================
Apéndice D: Conectividad basada en superficie
======================================

-------

Descripción general
********

Los análisis que realizó en los capítulos anteriores se realizaron en el llamado **espacio volumétrico**; cada imagen tiene vóxeles individuales adquiridos con una longitud, anchura y altura específicas, y la serie temporal se promedia entre los grupos de vóxeles dentro de cada región. Esto funciona bien para la mayoría de los propósitos; sin embargo, la conectividad funcional puede presentar los mismos problemas que el análisis basado en tareas durante el preprocesamiento del suavizado.Como se señala en un artículo reciente de Brodoehl et al. (2020) 
    `__, el suavizado permite promediar la señal en áreas funcionalmente heterogéneas, lo cual puede ser especialmente problemático para los análisis de conectividad. Por ejemplo, las crestas de dos giros cercanos pueden estar a pocos milímetros de distancia entre sí al observarse desde arriba, aunque la distancia real de pico a pico (recorriendo la cresta del giro, como descendiendo de una colina a un valle y subiendo por la otra) puede ser mucho mayor.

.. figure:: ApéndiceD_Brodoehl_Figura1.png

  Figura 1 de Brodoehl et al. (2020). Cabe destacar que la distancia euclidiana (es decir, la distancia en línea recta) entre crestas adyacentes de la corteza puede ser de tan solo cuatro milímetros. La distancia real entre crestas, atravesando los valles de la corteza, es diez veces mayor.

Esta distancia se representa con mayor precisión al reconstruir la imagen en el **espacio superficial**. En resumen, realizar análisis de conectividad funcional y basados en tareas en la superficie permite el uso de núcleos de suavizado más grandes sin los problemas de contaminación de señal que presenta el suavizado en el espacio volumétrico. Esto puede aumentar la potencia y reducir la probabilidad de suavizado entre regiones o diferentes tipos de tejido. (Se pueden encontrar más detalles sobre las diferencias entre el análisis volumétrico y el basado en la superficie en el módulo SUMA).
     `.) Para el resto del capítulo, necesitarás estar familiarizado con FreeSurfer; el tutorial se puede encontrar :ref:`aquí 
      `. Una vez que haya terminado ese tutorial y haya aprendido a usar el comando ``recon-all``, siga los pasos a continuación para modificar su proyecto CONN para analizar datos de superficie.

Creando la superficie
********************

Para el resto de este tutorial, utilizaremos los primeros tres temas de la tarea de Aritmética en OpenNeuro.org, que se pueden encontrar aquí.
       `__. Si siguió los pasos de los capítulos anteriores, debería haber descargado el conjunto de datos completo. Vaya a la carpeta ``Aritmética`` y escriba el siguiente código:

::

  para i en sub-01 sub-02 sub-03; hacer
    cd $i/anat;
    ASUNTOS_DIR=`pwd`;
    recon-all -s $i -i ${I}_T1w.nii -all;
    cd ../..;
  hecho
  
Esto ejecutará recon-all secuencialmente en cada directorio ``anat``. Como alternativa, si tiene varios procesadores en su computadora, puede abrir tres terminales separadas y ejecutar recon-all en cada una; o bien, puede usar el comando :ref:`parallel
        
         `. Las últimas dos opciones completarán recon-all más rápidamente al procesar cada sujeto en paralelo. En cualquier caso, debería poder procesar los tres sujetos en aproximadamente un día. Cargando los datos de superficie en CONN ********************************** Cuando ``recon-all`` termine, tendrá un nuevo directorio dentro de la carpeta ``anat`` de cada sujeto. Cada uno de estos directorios de FreeSurfer contendrá subcarpetas como ``mri`` y ``surf``, que necesitará para importar los datos de superficie en CONN. Primero, abra una terminal de Matlab y abra la caja de herramientas de CONN. Cree un nuevo proyecto llamado ``Arithmetic_Surface``, que abrirá la pestaña Configuración. Ingrese ``3`` para el número de sujetos y cambie el TR a ``3.56``. A continuación, haga clic en el botón ``Estructural``. Dentro de los directorios de salida de FreeSurfer, hay un archivo llamado ``T1.mgz`` en la subcarpeta ``mri``. En el campo ``Buscar``, escriba ``T1.mgz`` y luego presione el botón ``Buscar``; debería ver una nueva lista de archivos que contienen la cadena ``T1.mgz``. Mantenga presionada la tecla Mayús y haga clic para resaltar todos los sujetos en el campo ``Datos estructurales`` y luego mantenga presionada la tecla Ctrl y haga clic izquierdo para seleccionar los archivos T1.mgz correspondientes para cada sujeto y haga clic en ``Importar``. Esto detectará automáticamente el archivo anatómico reconstruido de la superficie, junto con cualquier archivo de segmentación. Si se cargan los archivos aseg.mgz, puede omitir el paso de segmentación durante el preprocesamiento (que se explica con más detalle a continuación). .. figure::AppendiceD_LoadStructurals.png Los datos funcionales, por el contrario, todavía están en el espacio volumétrico; durante el preprocesamiento, se volverán a muestrear al espacio de la superficie. Haga clic en ``Funcional``. Similar a lo que hicimos arriba, ingrese ``task-rest_bold.nii.gz`` en el campo ``Buscar``; resalte los tres temas en la ventana ``Datos funcionales`` y luego control y clic para seleccionar sus archivos funcionales correspondientes. .. figure::AppendiceD_LoadFunctionals.png Cargando las ROI de FreeSurfer *************************** Aunque la caja de herramientas CONN no tiene un atlas de FreeSurfer incluido, puede crearlo a través de la pestaña Configuración. Haga clic en el botón ``ROI``, y luego pase el cursor sobre la ventana ROI y haga clic en el botón ``nuevo`` en la parte inferior de la ventana. Llame a la nueva ROI ``FS_Atlas``, y en el campo "Buscar" escriba ``lh.aparc.annot``. (No importa si usa el hemisferio izquierdo o el hemisferio derecho; las ROI para ambos se cargarán automáticamente). Seleccione el archivo ``sub-01/anat/fsaverage/label/lh.aparc.annot`` y luego haga clic en ``Importar``. Cuando termine la importación, asegúrese de que la casilla ``Archivo Atlas`` esté marcada en la parte inferior de la ventana. .. figure::AppendiceD_LoadROIs.png Ejecución del preprocesamiento ************************* Antes de preprocesar las imágenes, primero haga clic en ``Opciones`` y cambie el ``Espacio de análisis (nivel de vóxel)`` a ``Superficie: igual que la plantilla (Freesurfer fsaverage)``. Esto llevará a cabo todos los análisis de primer y segundo nivel en la plantilla FreeSurfer fsaverage,que está en el espacio MNI. También desmarcaría el botón ``Voxel-to-Voxel``, para ahorrar tiempo; puede realizar este análisis más tarde si lo desea. A continuación, haga clic en el botón ``Preprocesamiento`` y seleccione ``canalización de preprocesamiento para análisis basados en superficie (en el espacio del sujeto)``. Si tiene el tiempo y la potencia de procesamiento, puede elegir la opción de corregistro no lineal, que toma más tiempo pero genera un remuestreo más preciso de los datos volumétricos al espacio de superficie. En este ejemplo, eliminaré la corrección de tiempo de corte (ya que no sé cómo se adquirieron los cortes en este experimento), y también la segmentación, ya que las imágenes anatómicas ya fueron segmentadas por FreeSurfer y las segmentaciones se importaron. Cuando finalice el preprocesamiento, regrese a la sección ``ROI`` y haga clic en ``FS_Atlas``. En ``Calcular series temporales promedio``, seleccione ``del conjunto de datos secundario n.º 4 (datos del espacio de superficie)``. Esto utilizará la serie temporal promediada de la materia gris remuestreada en la superficie, en lugar de los datos volumétricos. Cuando haya terminado todo esto, haga clic en el botón ``Listo`` para ejecutar la canalización de configuración. .. nota:: Una vez finalizado el preprocesamiento, puede ver los mapas de conectividad funcional en las superficies de los sujetos individuales haciendo clic en el botón ``Funcional``. Similar al análisis volumétrico, verá el primer volumen en el lado izquierdo y el último volumen de la serie temporal en el lado derecho. Eliminación de ruido ********* La pestaña Eliminación de ruido será la misma que durante el análisis de conectividad funcional volumétrica, y la interpretación de las distribuciones de conectividad y la corrección de los componentes principales es la misma. La única diferencia es que verá la varianza BOLD proyectada sobre una superficie para cada sujeto, en lugar de su volumen. .. figure:: ApéndiceD_Denoising.png Análisis de Primer Nivel ******************** La pestaña Análisis de Primer Nivel también será muy similar a un análisis volumétrico, excepto que esta vez los resultados se proyectan sobre una superficie cortical. Para ahorrar tiempo, eliminaremos todas las "Semillas/Fuentes Seleccionadas" excepto las tres primeras ROI listadas en el "FS_Atlas" que especificamos en la pestaña "Configuración": "FS_Atlas.bankssts (L)", "FS_Atlas.caudalanteriorcingulate (L)" y "FS_Atlas.caudalmiddlefrontal (L)". Mantenga los demás valores predeterminados y haga clic en el botón "Listo". Una vez finalizado, puede volver a esta pestaña y ver los mapas de conectividad de cada ROI especificada. .. figure:: ApéndiceD_1erNivel.png Análisis de segundo nivel ********************* Una vez obtenidos los resultados de primer nivel, puede resaltar cualquiera de las regiones y hacer clic en el botón "Calcular resultados". Esto mostrará un resultado a nivel de grupo en la pestaña "Segundo nivel" y también generará una ventana con un cerebro de cristal y la tabla correspondiente de clústeres significativos. Si hace clic en el botón "Visualización de superficie" (el primero en la esquina superior izquierda de los botones bajo "Mostrar e imprimir",puede ver con mayor precisión los resultados de conectividad que se muestran en la superficie de la corteza. .. figure:: ApéndiceD_GroupResults.png .. nota:: A partir de la versión actual utilizada en estos tutoriales (21.a), no parece que las parcelaciones corticales tanto subcorticales como superficiales se puedan combinar en el mismo análisis; consulte este hilo
         
          `__ para más detalles. Vídeo ***** Para ver una demostración en vídeo sobre cómo realizar un análisis basado en superficies en la caja de herramientas CONN, haga clic `aquí
          
           `__. Próximos pasos ********** Todas las demás opciones para el análisis volumétrico, incluyendo pruebas de muestras independientes, la adición de covariables y análisis ROI a ROI, son las mismas en este caso; la única diferencia es que los resultados se muestran en la superficie. Consulte los capítulos anteriores para obtener una guía sobre cómo ejecutar estos otros análisis.
          
         
        
       
      
     
    
   

