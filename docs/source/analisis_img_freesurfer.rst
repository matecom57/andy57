Analisis de datos con freesurfer
================================

.. code:: Bash

   ls sub-112/ses-BL/anat

Tutorial n.º 3 de FreeSurfer: Reconocimiento total

.. code:: Bash

   recon-all -s sub-101 -i sub-101_ses-BL_T1w.nii.gz -all

.. code:: Bash
   
   recon-all -s <subjectName> -qcache

Tutorial de FreeSurfer n.° 4: Ejecución de recon-all en paralelo


Descarga del comando paralelo

Volviendo a FreeSurfer, normalmente solo se usa un núcleo cada vez que se ejecuta recon-all. Con un comando 
llamado parallel , cada instancia de recon-all se puede asignar a un núcleo diferente. Si usa una computadora 
Macintosh, puede ver el número de núcleos escribiendo lo siguiente:


Uso del comando paralelo


Parallel se ejecuta canalizando la salida del lscomando hacia el comando paralelo. Por ejemplo, si tiene seis 
imágenes anatómicas etiquetadas como sub1.nii, sub2.nii y sub6.nii, puede analizarlas en paralelo escribiendo 
lo siguiente:


.. code:: Bash

   ls *.nii | parallel --jobs 8 recon-all -s {.} -i {} -all -qcache
 
Análisis del conjunto de datos sobre el cannabis

.. code:: Bash

   ls .. | grep ^sub- > subjList.txt

   for sub in `cat subjList.txt`; do
     cp ../${sub}/ses-BL/anat/*.gz .
   done

   gunzip *.gz

   SUBJECTS_DIR=`pwd`

   ls *.nii | parallel --jobs 8 recon-all -s {.} -i {} -all -qcache

   rm *.nii

   for sub in `cat subjList.txt`; do
     mv ${sub}_ses-BL_T1w.nii ${sub}
   done


Tutorial n.º 5 de FreeSurfer: Cómo usar la cuadrícula de ciencia abierta

Preparación de sus datos para la Red de Ciencia Abierta

.. code:: Bash

   curl -L -o fsurf 'http://stash.osgconnect.net/+fsurf/fsurf'
   chmod +x fsurf

.. code:: Bash

   sudo mv fsurf /bin


.. code:: Bash

   ls | grep sub- > subjList.txt

Envío de trabajos de Recon-All

Primero deberá ejecutar recon-all en sus imágenes anatómicas, omitiendo la -allopción. Esto creará una serie 
de directorios y luego convertirá la imagen anatómica al formato .mgz y la colocará en el mri/origdirectorio. 
El siguiente código puede copiarse y pegarse en la terminal o copiarse en un script de shell y ejecutarse con 
tcsh:



.. code:: Bash

   foreach subj (`cat subjList.txt`)
      cd $subj/ses-BL/anat
      if (! -d $subj ) then #If the FS directory doesn't exist, then run recon-all
              recon-all -s $subj -i *.nii.gz -sd .
              #zip the FreeSurfer directories, so they can be submitted to fsurf
              zip -r $subj.zip $subj
              cd ../../..
      else
              echo "FreeSurfer folder for $subj already exists; if you want to rerun recon-all for this subject, delete the folder and rerun this script."
              cd ../../..
      endif
  end


Una vez finalizado, puedes enviar los trabajos usando fsurf. En este ejemplo, he incluido fsurfun bucle for:


.. code:: Bash

   foreach subj (`cat subjList.txt`)
      cd $subj/ses-BL/anat
      fsurf submit --subject=$subj --input=$subj.zip --defaced --deidentified --version 6.0.0 --freesurfer-options='-all -qcache -3T'
      cd ../../..
   end

Descargar o eliminar trabajos

.. code:: Bash

   fsurf output --id <subjID>

.. code:: Bash

   fsurf remove --id <subjID>

Tutorial de FreeSurfer n.º 6: Freeview

Opciones de Freeview desde la línea de comandos


.. code:: Bash

   freeview -v mri/orig.mgz mri/aseg.mgz:colormap=LUT -f surf/lh.pial:edgecolor=yellow


Tutorial de FreeSurfer n.° 7: El archivo FSGD


Antes de comenzar este tutorial, cree un directorio llamado FSdentro del Cannabisdirectorio. Este 
FSdirectorio debe contener todos los directorios generados por recon-all. Ejecute los comandos recon-all 
desde ese directorio o muévalos al directorio FS con el mvcomando.

Organizando los directorios

.. code:: Bash

   cp -R $FREESURFER_HOME/subjects/fsaverage .

Para copiar la plantilla fsaverage. Una vez hecho esto, establezca la variable SUBJECTS_DIR en el directorio 
actual escribiendo . Esto colocará la salida de cualquier comando recon-all o de análisis de grupo en el 
directorio actual:export SUBJECTS_DIR=`pwd`

.. code:: Bash

   setenv SUBJECTS_DIR `pwd`


También crearemos dos directorios llamados FSGDy Contrasts, que contendrán los archivos de texto necesarios 
para ejecutar nuestro análisis:


.. code:: Bash

   mkdir FSGD Contrasts

Creación del archivo FSGD

El conjunto de datos de cannabis incluye un archivo llamado " participants.tsvque contiene etiquetas y 
covariables para cada sujeto: grupo, género, edad, inicio del consumo de cannabis, etc.". Para crear un 
archivo de descriptor de grupo de FreeSurfer (FSGD), extraemos las covariables o etiquetas de grupo que nos 
interesan y las formateamos de forma que FreeSurfer las comprenda. El archivo FSGD contendrá las covariables 
que queremos contrastar y un archivo de contraste independiente indicará qué covariables contrastar y qué 
ponderaciones asignarles.


Para mantener nuestros archivos organizados, copie el archivo candidates.tsv en el directorio FSGD y cámbiele 
el nombre CannabisStudy.tsv:


.. code:: Bash

   cp ../participants.tsv FSGD/CannabisStudy.tsv.

Ahora, abra el archivo CannabisStudy.tsven Excel. Lo reformatearemos como un archivo FSGD, organizado de 
forma que sea comprensible para los comandos de análisis de grupos que ejecutaremos más adelante. En la 
primera columna, escriba las siguientes cuatro líneas:


.. code:: Bash

   GroupDescriptorFile 1 
   Title CannabisStudy
   Class HC
   Class CB

Creando el archivo de contraste

Nuestro siguiente paso es crear un archivo de contraste que especifique los pesos de contraste para cada regresor de nuestro modelo. Las variables "Clase" que especificamos en el archivo FSGD son regresores de grupo: uno para el grupo de cannabis y otro para el grupo de control. Dado que solo tenemos dos regresores, solo necesitamos especificar dos pesos de contraste.

Para especificar estos pesos, navegue hasta el Contrastsdirectorio y luego escriba:

.. code:: Bash

   echo "1 -1" > HC-CB.mtx

Ahora crea otro archivo de contraste para el contraste opuesto, es decir:

.. code:: Bash

   echo "-1 1" > CB-HC.mtx

Ceremonias

Tutorial de FreeSurfer n.° 8: Análisis de grupo

Creando un archivo de grupo con mris_preproc

Para hacer el comando más compacto y adaptable a cualquier estudio que desee analizar, utilizaremos bucles for anidados:

.. code:: Bash

   #!/bin/tcsh

   setenv study $argv[1]

   for each hemi (lh rh)
     foreach smoothing (10)
       foreach meas (volume thickness)
         mris_preproc --fsgd FSGD/{$study}.fsgd \
           --cache-in {$meas}.fwhm{$smoothing}.fsaverage \
           --target fsaverage \
           --hemi {$hemi} \
           --out {$hemi}.{$meas}.{$study}.{$smoothing}.mgh
       end
     end
   end


Ajuste del modelo lineal general con mri_glmfit

Ahora que todos los sujetos están concatenados en un único conjunto de datos, podemos ajustar un modelo lineal general con mri_glmfitel comando FreeSurfer. En este ejemplo, utilizaremos las siguientes entradas:

    1. El conjunto de datos concatenados que contiene todos los mapas estructurales de los sujetos ( --y);

    2. El archivo FSGD ( --fsgd);

    3. Una lista de contrastes (cada contraste especificado por una línea diferente que contiene --C);

    4. El hemisferio de la plantilla a analizar ( --surf);

    5. Una máscara para restringir nuestro análisis sólo a la corteza ( --cortex);

    6. Una etiqueta de salida para el directorio que contiene los resultados ( --glmdir).

.. code:: Bash

   #!/bin/tcsh

   set study = $argv[1]

   foreach hemi (lh rh)
     foreach smoothness (10)
       foreach meas (volume thickness)
           mri_glmfit \
           --y {$hemi}.{$meas}.{$study}.{$smoothness}.mgh \
           --fsgd FSGD/{$study}.fsgd \
           --C Contrasts/CB-HC.mtx \
           --C Contrasts/HC-CB.mtx \
           --surf fsaverage {$hemi}  \
           --cortex  \
           --glmdir {$hemi}.{$meas}.{$study}.{$smoothness}.glmdir
       end
     end
   end

Revisando la salida



Si los scripts se ejecutan sin errores, debería ver los siguientes directorios en su directorio actual:

.. code:: Bash

   lh.thickness.CannabisStudy.10.glmdir
   lh.volume.CannabisStudy.10.glmdir
   rh.thickness.CannabisStudy.10.glmdir
   rh.volume.CannabisStudy.10.glmdir












