Apéndice D: Segmentación de los subcampos del hipocampo, la amígdala, el tronco encefálico y el tálamo
===============================================================================

---------------

Descripción general
********

Dentro de una estructura tan diminuta como la amígdala —una región cerebral del tamaño de un anacardo, de aproximadamente un centímetro de diámetro— existen numerosas subdivisiones, alrededor de una docena, con diferentes funciones. También existen subregiones del tálamo, el tronco encefálico y el hipocampo que los investigadores aún están explorando.

Puede segmentar estas regiones en sus partes con el comando ``segment_subregions`` de FreeSurfer. Disponible en las versiones más recientes de FreeSurfer (7.3.x y posteriores), este comando combina las funciones de los comandos de segmentación independientes utilizados en versiones anteriores de FreeSurfer, como ``segment_HA``, ``recon-all -brainstem-structures`` y ``segmentThalamicNuclei``. Tenga en cuenta que solo acepta imágenes anatómicas ponderadas en T1 y que no se pueden utilizar imágenes ponderadas en T2.

La ventaja del nuevo comando es que permite elegir cualquiera de las subregiones individualmente o segmentarlas en secuencia. Además, no requiere el entorno de ejecución de Matlab, cuya instalación en clústeres de supercomputación podría ser difícil.

Suponiendo que ya ha ejecutado un tema a través de ``recon-all`` y que está segmentando un escaneo (es decir, no está haciendo un análisis longitudinal), puede escribir lo siguiente (asegurándose de configurar también ``SUBJECTS_DIR`` en el directorio desde el que está ejecutando ``segment_subregions``):

::

  segmento_subregiones hipo-amygdala --cross $subject

En el que ``$subject`` se reemplaza por el nombre del directorio que contiene la salida de FreeSurfer.

Por ejemplo, imaginemos que analizamos los datos de un estudio de Fink et al. (2021) que examinó si el volumen de diferentes subregiones del hipocampo aumentó al hacer que los sujetos corrieran durante dos semanas. Si descargamos el archivo de uno de los sujetos —en este caso, ``sub-season217``—, vemos que el participante tiene tres sesiones (``ses-1``, ``ses-2`` y ``ses-3``), cada una con un directorio ``anat`` que contiene una exploración anatómica ponderada en T1. Supongamos que analizamos el directorio ``ses-1`` navegando a ``sub-season217/ses-1`` y escribiendo:

::

  SUBJECTS_DIR=`pwd`
  recon-all -s sub-temporada217 -i sub-temporada217_ses-1_acq-MPrageHiRes_T1w.nii.gz -all

Una vez terminado esto, podemos ejecutar este comando desde el mismo directorio para segmentar las subregiones del hipocampo y la amígdala:


::

  segmento_subregiones hipopótamo-amígdala --cruz sub-temporada217

Lo cual, después de unos quince minutos, generará diferentes niveles de granularidad para las segmentaciones, tanto para el hemisferio izquierdo como para el derecho:

.. figura:: ApéndiceD_SegOutput_MRI.png

  Resultados de ``segment_subregions`` para el hipocampo y la amígdala. Aquí se muestran las segmentaciones del hemisferio izquierdo, que se encuentran en el directorio ``mri``. El volumen con el esquema de etiquetado más completo es ``lh.hippoAmygLabels.mgz``; el significado de los demás sufijos se puede encontrar en ``esta página``.`__ en la sección "Motivación y descripción general". Los archivos ``lh.amygNucVolumes.txt`` y ``lh.hippoSfVolumes.txt`` contienen las estimaciones de volumen para cada subregión de la amígdala y el hipocampo, respectivamente.

Las segmentaciones se pueden luego visualizar en Freeview cargándolas como volúmenes, junto con el archivo ``brainmask.mgz`` como base:

.. figura:: ApéndiceD_VisualizarSegmentaciones_Freeview.png

Ejecución de segment_subregions en un clúster de supercomputación
*******************************************************

Este análisis también puede ejecutarse en un clúster de supercomputación utilizando una plantilla similar a la siguiente. Tenga en cuenta que ``freesurfer/7.4.1`` se carga como módulo y que se llaman tres instancias independientes de ``segment_subregions``, cada una segmentando una estructura diferente. Se asignan dos horas para todo el proceso, aunque cada segmentación tarda entre 10 y 15 minutos:


::

  #!/bin/bash

  #----------------------------
  # Variables de Slurm
  
  #SBATCH --nombre-trabajo=FinkInterventionSeg
  #SBATCH --tiempo=2:00:00
  
  #SBATCH --nodos=1
  #SBATCH --ntasks-per-node=1
  #SBATCH --cpus-por-tarea=1
  #SBATCH --mem=8gb
  
  #SBATCH --cuenta=ajahn0
  #SBATCH --partición=estándar
  
  #SBATCH --tipo-de-correo=NINGUNO
  
  #------------------------------
  # Cargar módulos
  módulo de carga freesurfer/7.4.1
  
  #------------------------------
  # Imprimir información de diagnóstico en el archivo de salida del trabajo
  encabezado_de_mi_trabajo
  
  #------------------------------
  # Comandos a ejecutar durante el trabajo
  cd sub-temporada217/ses-1/anat
  SUBJECTS_DIR=`pwd`
  segmento_subregiones hipopótamo-amígdala --cruz sub-temporada217
  segmento_subregiones tálamo --cruz sub-temporada217
  segmento_subregiones tronco encefálico --cross sub-season217


Todas las segmentaciones se pueden cargar en Freeview al mismo tiempo:

.. figura:: ApéndiceD_VisualizarTodasLasSegmentaciones.png

Se pueden realizar análisis adicionales del ROI extrayendo los datos del archivo de texto correspondiente. Por ejemplo, aquí están los datos del archivo ``rh.amygNucVolumes.txt``, que se pueden cargar fácilmente en una hoja de cálculo como Excel:

::

  Núcleo lateral 641.904705
  Núcleo basal 407.362812
  Núcleo basal accesorio 254.086566
  Área amigdaloidea anterior AAA 49.233018
  Núcleo central 40.191365
  Núcleo medial 15.293715
  Núcleo cortical 27.076169
  Transición corticoamigdalina 166.302591
  Núcleo paralaminar 45.725635
  Amígdala completa 1647.176577


Video
*****

Para ver un video tutorial sobre cómo utilizar ``segment_subregions``, haga clic aquí
    `__.

    
   

