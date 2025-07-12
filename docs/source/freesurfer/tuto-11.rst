Tutorial de FreeSurfer n.º 11: Análisis de la región de interés
====================================================

---------------

Descripción general
********

Además de crear una superficie cortical y calcular las mediciones estructurales en cada vértice, FreeSurfer parcela y segmenta el cerebro: las parcelaciones delimitan las regiones anatómicamente diferenciadas de la corteza y las segmentaciones dividen los núcleos subcorticales en estructuras distintas. Estas parcelaciones se crean siguiendo los lineamientos de dos atlas incluidos en FreeSurfer: el atlas de Destrieux y el atlas de Desikan-Killiany.

Dentro del directorio "stats" de cada asignatura, hay una tabla correspondiente a las parcelaciones de cada atlas. Por ejemplo, los resultados de la parcelación del hemisferio izquierdo se encuentran en el archivo "lh.aparc.annot" para el atlas de Desikan-Killiany, y en el archivo "lh.aparc.a2009s.annot" para el atlas de Destrieux. La principal diferencia entre ambos es que el atlas de Destrieux contiene más parcelaciones que permiten análisis más detallados.

.. figura:: 11_Atlas_Comparación.png

  Los atlas de Desikan-Killiany y Destrieux, uno junto al otro. Nótese que el atlas de Destrieux contiene más parcelaciones de la corteza.
  
  
Las segmentaciones, por otro lado, se encuentran en un solo archivo llamado «aseg.stats». No existen archivos de segmentación separados para cada atlas.


Extracción de datos con asegstats2table y aparcstats2table
**********************************************************

Tanto el comando ``asegstats2table`` como ``aparcstats2table`` requieren una lista de sujetos y la medida estructural que desea extraer de la tabla.

Comencemos con ``asegstats2table``. Un comando típico se vería así:

::

  asegstats2table --subjects sub-101 sub-103 --common-segs --meas volumen --stats=aseg.stats --table=segstats.txt


1. La opción ``--subjects`` especifica una lista de nombres de sujetos;
2. ``--common-segs`` indica que se deben generar segmentaciones comunes a todos los sujetos; en otras palabras, si el número de segmentaciones de un sujeto es diferente al de los demás, no salga del comando con errores;
3. ``--meas`` indica qué medida estructural extraer de la tabla ("volumen" es el valor predeterminado; las alternativas son "media" y "estándar");
4. ``--stats`` apunta al archivo de estadísticas del que se extraerán los datos de segmentación; y
5. ``--table`` escribe la medición extraída en un archivo de texto, organizado por nombre de tema.


El comando ``aparcstats2table`` requiere argumentos similares. A continuación, se muestra un comando típico:

::

  aparcstats2table --subjects sub-101 sub-103 --hemi lh --meas espesor --parc=aparc --tablefile=aparc.txt
  
En este comando, puede especificar el hemisferio a analizar (``--hemi``), la medida a extraer (``--meas``, con las opciones "thickness", "volume", "area" y "meancurv") y el atlas a utilizar para la parcelación (``--parc``; puede especificar "aparc", el atlas de Desikan-Killinay, o "aparc.a2009s", el atlas de Destrieux). La etiqueta del archivo de salida se especifica con la opción ``--tablefile``. Incluya tantos sujetos como desee en su análisis.


Próximos pasos
*********

El resultado de estos comandos son archivos de texto delimitados por tabulaciones que se pueden leer en una hoja de cálculo como Excel o en un programa de software estadístico como R. Realizaría las pruebas estadísticas como lo haría con cualquier otra prueba t: seleccione las mediciones estructurales de los grupos que desea comparar y luego contraste los dos grupos entre sí.

.. nota::

  En el futuro, añadiré secciones sobre cómo remuestrear una ROI volumétrica a la superficie y luego extraer mediciones estructurales de dicha ROI. El código a continuación se creó hace tiempo, pero debería funcionar para la mayoría de los propósitos.


::
  
  #!/bin/tcsh

  setenv SUBJECTS_DIR `pwd`

  #Cree una ROI de esfera de 5 mm con 3dUndump; ROI_file.txt contiene las coordenadas x, y y z para el centro de la esfera (por ejemplo, 0 30 20)
  3dUndump -srad 5 -prefijo S2.nii -master MNI_caez*+tlrc.HEAD -orient LPI -xyz ROI_file.txt

  #Ver en tkmedit
  tkmedit -f MNI_caez_N27.nii -overlay S2.nii -fthresh 0.5

  #Registrar plantilla anatómica para ahorrar dinero (plantilla FreeSurfer)
  fslregister --s fsaverage --mov MNI_caez_N27.nii --reg tmp.dat

  #Ver el ROI en fsaverage
  tkmedit fsaverage T1.mgz -overlay S2.nii -overlay-reg tmp.dat -fthresh 0.5 -superficie izquierda.blanco -aux-superficie derecha.blanco


  #Mapa ROI a superficie promedio
  mri_vol2surf --mov S2.nii \
          --reg tmp.dat \
          --projdist-max 0 1 0.1 \
          --interp más cercano \
          --hemi lh \
          --salida lh.fsaverage.S2.mgh \
          --noreformar

  #Comprueba qué tan bien se corresponde el ROI con la superficie inflada
  tksurfer fsaverage lh inflado - superposición lh.fsaverage.S2.mgh -fthresh 0.5
  
  
Por el contrario, podría querer remuestrear una ROI de superficie a un volumen y luego extraer datos de ella; por ejemplo, supongamos que queremos convertir la ROI temporal superior creada por FreeSurfer al espacio volumétrico del sujeto individual. Primero, cree un archivo de registro llamado ``register.dat`` con el comando ``tkregister2`` de FreeSurfer:

::

  tkregister2 --mov beta_0001.nii --s asunto --noedit --regheader --reg Register.dat
  
Donde "beta_0001.nii" es un mapa beta creado en el espacio nativo del sujeto y "subject" es el nombre del sujeto que ha sido preprocesado con recon-all.

Luego usamos el comando ``mri_label2vol`` para convertir el ROI de la superficie al espacio volumétrico:

::

  mri_label2vol --label lh.superiortemporal.label --temp beta_0001.nii --subject subject --hemi lh --fillthresh .9 --proj frac 0 1 .1 --reg register.dat --o $PWD/stgnew.nii
  
En este caso, creamos un nuevo archivo, ``stgnew.nii``, que es el ROI de la superficie convertido al espacio volumétrico.


-----------

Video
*****

Para ver una descripción general en video sobre cómo realizar el análisis de la región de interés en FreeSurfer, haga clic aquí`__.

   

