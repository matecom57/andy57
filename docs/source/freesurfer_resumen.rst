La salida de Recon-all
======================

* Recon-all primero separa el cráneo de la imagen anatómica para generar un conjunto de datos llamado brainmask.mgz.

* Los archivos generados como volúmenes tridimensionales se almacenan en una carpeta llamada **mri**.

* Recon-all luego estima la superficie de contacto entre la materia blanca y la materia gris en ambos hemisferios. 
Estas estimaciones de superficie se almacenan en los archivos **lh.orig** y **rh.orig**.

* Esta estimación inicial se refina y se guarda en los archivos lh.white y rh.white.

* Una vez alcanzado este borde, se crea un tercer par de conjuntos de datos: lh.pial y rh.pial. 

* Una de las ventajas de usar estas superficies es la capacidad de representar, dentro de los surcos, mediciones como 
las diferencias de grosor cortical o la señal BOLD.

* Para un ejemplo de cómo analizar datos de fMRI en una superficie generada por FreeSurfer, consulte este tutorial 
sobre SUMA

* Recon-all parcelará el cerebro del sujeto según dos atlas: el atlas de Desikan-Killiany y el atlas de Destrieux. El 
atlas de Destrieux contiene más parcelaciones; la que se utilice para el análisis dependerá de la precisión del 
análisis que se desee realizar.

**Usando el comando Recon-all**

Si se encuentra en el directorio de Cannabis, navegue al directorio anatómico de sub-101 escribiendo 

.. code:: Bash

   cd sub-101/ses-BL/anat

A continuación, puede ejecutar recon-all con el siguiente comando:

.. code:: Bash

   recon-all -s sub-101 -i sub-101_ses-BL_T1w.nii.gz -all

Por defecto, $SUBJECTS_DIR es una variable que apunta al directorio $FREESURFER_HOME/subjects, donde $FREESURFER_HOME 
es otra variable que apunta al directorio donde se instaló FreeSurfer, como `/usr/local/freesurfer`. En otras 
palabras, 
la salida de este comando recon-all estará en `/usr/local/freesurfer/subjects`.

También recomiendo añadir la opción `qcache`, que suavizará los datos en diferentes niveles y los almacenará en el 
directorio de salida del sujeto. Esto será útil para análisis a nivel de grupo.

**análisis en paralelo**

* Una forma de reducir el tiempo que lleva analizar tantos sujetos es ejecutar los análisis en paralelo.

* Descarga del comando paralelo

* La primera entrada es el número de núcleos físicos, que es 4; y la segunda entrada es el número de núcleos lógicos, 
que es 8.

* El comando paralelo no viene de serie con el sistema operativo Macintosh; deberá descargarlo. Es necesario 
descargar la aplicación Xcode, disponible en la App Store de Macintosh.


 sysctl -n hw.ncpu


**Uso del comando paralelo**

Por ejemplo, si tiene seis imágenes anatómicas etiquetadas como sub1.nii, sub2.nii … sub6.nii, puede analizarlas en 
paralelo escribiendo lo siguiente:

.. code:: Bash

   ls *.nii | paralelo --jobs 8 recon-all -s {.} -i {} -all -qcache

Analicemos qué hace este comando:

* 1. El comando ls utiliza un comodín para expandir todas las imágenes anatómicas que tienen la extensión .nii.

* 2. La lista se envía al comando parallel, que utiliza la opción --jobs 8 para indicar que se usarán 8 núcleos para 
analizar los datos. Cada instancia de recon-all se asignará a un núcleo diferente.

* 3. El punto entre llaves para la opción -s significa que se debe eliminar la extensión .nii; en otras palabras, la 
entrada a -s será sub1, sub2 … sub6.

* 4. La opción -i indica utilizar la salida del comando ls como entrada para el comando parallel.

* 5. Las opciones -all y -qcache tienen el mismo significado que lo discutido en el tutorial anterior sobre 
recon-all.

**Análisis del conjunto de datos sobre el cannabis**

* Si ha configurado el directorio correctamente, todos los temas deberían estar en una carpeta llamada “Cannabis”. 

* Cree otro directorio llamado “FS” y acceda a él. 

* Desde una consola bash (vea la nota anterior), escriba el siguiente código para ejecutar todos estos temas mediante 
el comando paralelo:

.. code:: Bash

   ls .. | grep ^sub- > subjList.txt

   para sub en `cat subjList.txt`; hacer
   cp ../${sub}/ses-BL/anat/*.gz .
   hecho

   gunzip *.gz

   SUBJECTS_DIR=`pwd`

   ls *.nii | paralelo --jobs 8 recon-all -s {.} -i {} -all -qcache

   rm *.nii

   para sub en `cat subjList.txt`; hacer
   mv ${sub}_ses-BL_T1w.nii ${sub}
   hecho







