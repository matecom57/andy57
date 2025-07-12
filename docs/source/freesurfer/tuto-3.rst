Tutorial n.º 3 de FreeSurfer: Reconocimiento total
=================================

Descripción general: reconstrucción de la superficie cortical
**********************************************

FreeSurfer contiene un amplio conjunto de programas que pueden tardar varias horas en procesar un solo sujeto y días en procesar un conjunto de datos completo. Afortunadamente, el procesamiento en sí es muy sencillo: FreeSurfer cuenta con un único comando que, al ejecutarse, realiza prácticamente todas las partes más tediosas del preprocesamiento de un solo sujeto. Este comando, **recon-all**, es fácil de usar y solo requiere unos pocos argumentos para ejecutarse. Más adelante, aprenderá a ejecutar varios comandos recon-all simultáneamente, lo que le ahorrará mucho tiempo.

Recon-all significa **reconstrucción**, es decir, la reconstrucción de una superficie cortical bidimensional a partir de un volumen tridimensional. Las imágenes que obtenemos de una resonancia magnética son bloques tridimensionales, y recon-all las transforma en una superficie bidimensional lisa y continua, similar a tomar una bolsa de papel para el almuerzo, arrugada hasta el tamaño de una bolita, y luego soplarla para expandirla como un globo.

.. figura:: 03_Reconstrucción.png

  El comando recon-all convierte un volumen anatómico tridimensional (mostrado a la izquierda, representado por un corte sagital típico de un volumen) en una superficie bidimensional (derecha). Como verá en el tutorial de Freeview`, FreeSurfer crea varios tipos diferentes de cerebros inflados que puedes usar para visualizar tus resultados.
    


La salida de Recon-all
***********************

Antes de explicar cómo usar el comando recon-all, es útil ver ejemplos de lo que crea. Recon-all primero separa el cráneo de la imagen anatómica para generar un conjunto de datos llamado **brainmask.mgz**. (La extensión .mgz corresponde a un archivo comprimido del Hospital General de Massachusetts; es una extensión específica de FreeSurfer, similar a la extensión BRIK/HEAD de AFNI). Los archivos generados como volúmenes tridimensionales se almacenan en una carpeta llamada **mri**. Recon-all luego estima la superficie de contacto entre la materia blanca y la materia gris en ambos hemisferios. Estas estimaciones de superficie se almacenan en los archivos **lh.orig** y **rh.orig**.

Esta estimación inicial se refina y se guarda en los archivos **lh.white** y **rh.white**. Este límite se utiliza como base para que recon-all extienda los sensores y busque el borde de la materia gris. Una vez alcanzado este borde, se crea un tercer par de conjuntos de datos: **lh.pial** y **rh.pial**. Estos conjuntos de datos representan la superficie pial, que es como una película de plástico que envuelve el borde de la materia gris. Cada uno de estos conjuntos de datos puede visualizarse como una superficie o en el volumen 3D original mediante :ref:`freeview
    `.

.. figura:: 03_Orig_White_Pial.png

  Una ilustración de cómo recon-all crea diferentes superficies. La estimación original de la ubicación de la interfaz entre la materia blanca y la materia gris (amarilla) se refina para obtener una estimación más precisa (azul). Esta estimación refinada se utiliza para detectar el borde de la materia gris (roja). Estas superficies, tal como se ven en Freeview (el visor de FreeSurfer), se muestran a la derecha.

Una de las ventajas de usar estas superficies es la capacidad de representar, dentro de los surcos, mediciones como las diferencias de grosor cortical o la señal BOLD. En un volumen tridimensional, un solo vóxel puede abarcar dos crestas separadas de materia gris, lo que impide determinar qué parte de la corteza genera la señal observada. Para visualizar con mayor facilidad la ubicación de los mapas de activación a lo largo de las orillas de los surcos y las crestas de las circunvoluciones, los conjuntos de datos de superficie se pueden ampliar para crear los conjuntos de datos **lh.inflated** y **rh.inflated**. (Para un ejemplo de cómo analizar datos de fMRI en una superficie generada por FreeSurfer, consulte este tutorial sobre SUMA).
     `.

.. figura:: 03_Pial_Inflado.png

  Una ilustración de cómo convertir el archivo lh.pial en lh.inflated.
  
Estas superficies infladas pueden volver a inflarse, esta vez formando una esfera. Esta no es una imagen que se usaría para visualizar los resultados; es una imagen normalizada a una imagen plantilla llamada **fsaverage**, un promedio de 40 sujetos, y luego remodelada en una superficie inflada o una superficie pial. Una vez normalizado el mapa de superficie de cada sujeto a esta plantilla, se puede usar un atlas para **parcelar** la corteza en regiones anatómicamente distintas. Recon-all parcelará el cerebro del sujeto según dos atlas: el atlas de Desikan-Killiany y el atlas de Destrieux. El atlas de Destrieux contiene más parcelaciones; la que se utilice para el análisis dependerá de la precisión del análisis que se desee realizar.

.. figura:: 03_FreeSurfer_Atlases.png

  Comparación de los atlas de Desikan-Killiany (izquierda) y Destrieux (derecha). Obsérvese el mayor número de parcelaciones en el atlas de Destrieux en comparación con el de Desikan-Killiany.


Usando el comando Recon-all
***************************

Generaremos todas las imágenes mencionadas anteriormente con el comando recon-all, que solo requiere una imagen anatómica ponderada en T1 con buen contraste entre la sustancia blanca y la sustancia gris. Si se encuentra en el directorio de Cannabis, navegue al directorio anatómico de sub-101 escribiendo ``cd sub-101/ses-BL/anat``. A continuación, puede ejecutar recon-all con el siguiente comando:

::

  recon-all -s sub-101 -i sub-101_ses-BL_T1w.nii.gz -all
  
La opción ``-s`` especifica el nombre del sujeto, que puede configurarse como desee. La opción ``-i`` apunta a la imagen anatómica que analizará; y la opción ``-all`` ejecutará todos los pasos de preprocesamiento de sus datos. Excepto cuando vuelva a ejecutar el comando recon-all después de editar los datos.
      `, siempre querrás usar la opción ``-all``.

Mientras se ejecuta el comando, la salida se guardará en un directorio llamado $SUBJECTS_DIR. Por defecto, $SUBJECTS_DIR es una variable que apunta al directorio $FREESURFER_HOME/subjects, donde $FREESURFER_HOME es otra variable que apunta al directorio donde se instaló FreeSurfer, como ``/usr/local/freesurfer``. En otras palabras, la salida de este comando recon-all estará en ``/usr/local/freesurfer/subjects``.

.. nota::

  Si recibe un error de permiso al ejecutar recon-all, escriba lo siguiente:
  Sudo chmod -R a+w $SUJETOS_DIR
  Y luego vuelva a ejecutar el comando recon-all.
  

También recomiendo añadir la opción qcache, que suavizará los datos en diferentes niveles y los almacenará en el directorio de salida del sujeto. Esto será útil para análisis a nivel de grupo.
       `, que abordaremos en un próximo tutorial. Si ya ha ejecutado el preprocesamiento recon-all en sus sujetos, puede ejecutar qcache con el siguiente comando:

::

  recon-all -s
        
         -qcache, que debería tardar unos 10 minutos por sujeto. Próximos pasos ********** Podríamos ejecutar recon-all para cada uno de nuestros sujetos, uno por uno. Sin embargo, pronto descubrirá que esto es tedioso y poco práctico para analizar grandes conjuntos de datos. Aprenderemos a acelerar el proceso en el siguiente capítulo usando el comando ``parallel``. --------- Vídeo ***** Para ver un vídeo con una descripción general de recon-all y cómo usarlo, haga clic aquí.
         
          `__.
         
        
       
      
     
    
   

