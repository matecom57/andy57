Analisis img MRtrix
===================

Tutorial n.° 1 de MRtrix: Descargar e instalar

Afortunadamente, los desarrolladores han creado recientemente un comando de una sola línea que lo hará todo automáticamente:

.. code:: Bash

   sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"

Una vez descargado, abra una Terminal y escriba lo siguiente para probar su instalación:

.. code:: Bash

   mrview

Tutorial n.º 2 de MRtrix: Cómo descargar el conjunto de datos

Cuando finalice la descarga, descomprima la carpeta, abra una Terminal y cámbiele el nombre a BTC_preop:

.. code:: Bash

   mv ~/Downloads/ds001226-00001 ~/Desktop/BTC_preop

Tutorial n.º 3 de MRtrix: Análisis de los datos

Para ver cómo funciona, dirígete a la carpeta sub-CON02/ses-preop/dwique contiene tus datos de difusión. Uno de los primeros 
pasos para preprocesar tus datos es convertirlos a un formato compatible con MRtrix. Usaremos el comando mrconvertpara 
combinar los datos de difusión sin procesar con sus archivos correspondientes .bval, .bvecde modo que podamos usar el 
archivo combinado para futuros pasos de preprocesamiento:


.. code:: Bash

   mrconvert sub-CON02_ses-preop_acq-AP_dwi.nii.gz sub-02_dwi.mif -fslgrad sub-CON02_ses-preop_acq-AP_dwi.bvec sub-CON02_ses-preop_acq-AP_dwi.bval

Para que el resto del tutorial también sea más fácil de leer, use el mvcomando para cambiar el nombre de los archivos .bval 
y .bvec:

.. code:: Bash

   mv sub-CON02_ses-preop_acq-AP_dwi.bvec sub-02_AP.bvec
   mv sub-CON02_ses-preop_acq-AP_dwi.bval sub-02_AP.bval
   mv sub-CON02_ses-preop_acq-PA_dwi.bvec sub-02_PA.bvec
   mv sub-CON02_ses-preop_acq-PA_dwi.bval sub-02_PA.bval

La imagen de salida, sub-02_dwi.mif, se puede comprobar con el comando mrinfo:

.. code:: Bash

   mrinfo sub-02_dwi.mif

La comprobación más importante es asegurar que el número de bvals y bvecs coincida con el número de volúmenes del conjunto 
de datos. Por ejemplo, podemos encontrar el número de volúmenes del sub-02_dwi.mifconjunto de datos escribiendo:

.. code:: Bash

   mrinfo -size sub-02_dwi.mif | awk '{print $4}'

Esto devuelve un valor de 102, el número en el cuarto campo del encabezado de dimensiones que corresponde al número de 
puntos de tiempo, o volúmenes, en el conjunto de datos. Luego, comparamos esto con el número de bvals y bvecs usando awk 
para contar el número de columnas en cada archivo de texto:

.. code:: Bash

   awk '{print NF; exit}' sub-02_AP.bvec
   awk '{print NF; exit}' sub-02_AP.bval

Mirando los datos con mrview


.. code:: Bash

   mrview sub-02_dwi.mif

Tutorial n.° 4 de MRtrix: Preprocesamiento

dwi_denoise
El primer paso de preprocesamiento que realizaremos es eliminar el ruido de los datos mediante dwidenoiseel comando de 
MRtrix. Esto requiere un argumento de entrada y uno de salida, y también se puede generar el mapa de ruido con la 
-noiseopción. Por ejemplo:

.. code:: Bash

   dwidenoise sub-02_dwi.mif sub-02_den.mif -noise noise.mif

Una comprobación de calidad consiste en comprobar si los residuos se cargan en alguna parte de la anatomía. De ser así, 
podría indicar que la región cerebral se ve afectada de forma desproporcionada por algún tipo de artefacto o distorsión. 
Para calcular este residuo, utilizaremos otro comando de MRtrix llamado mrcalc:

.. code:: Bash

   mrcalc sub-02_dwi.mif sub-02_den.mif -subtract residual.mif

Luego puedes inspeccionar el mapa residual con mrview:

.. code:: Bash

   mrview residual.mif

En tal caso, se puede aumentar la intensidad del filtro de eliminación de ruido del valor predeterminado de 5 a un número 
mayor, como 7; por ejemplo,

.. code:: Bash

   dwidenoise your_data.mif your_data_denoised_7extent.mif -extent 7 -noise noise.mif

resonancia magnética_degibbs

Un paso opcional de preprocesamiento es ejecutar [ ] mri_degibbs, lo cual elimina los artefactos de anillo de Gibbs de los 
datos. Estos artefactos se asemejan a las ondas de un estanque y son más visibles en las imágenes con un valor b de 0. 
Analice primero sus datos de difusión con [ mrview] y determine si existen artefactos de Gibbs; si los hay, puede ejecutar [ 
] mrdegibbsespecificando un archivo de entrada y uno de salida, por ejemplo:

.. code:: Bash

   mrdegibbs sub-02_den.mif sub-02_den_unr.mif

Extracción de imágenes codificadas en fase inversa

Nuestro primer paso es convertir el archivo NIFTI con codificación de fase inversa al formato .mif. También añadiremos sus 
valores b y vectores b en el encabezado:

.. code:: Bash

   mrconvert sub-CON02_ses-preop_acq-PA_dwi.nii.gz PA.mif
   mrconvert PA.mif -fslgrad sub-02_PA.bvec sub-02_PA.bval - | mrmath - mean mean_b0_PA.mif -axis 3

A continuación, extraemos los valores b de la imagen codificada en fase primaria y luego combinamos los dos con mrcat:

.. code:: Bash

   dwiextract sub-02_den.mif - -bzero | mrmath - mean mean_b0_AP.mif -axis 3
   mrcat mean_b0_AP.mif mean_b0_PA.mif -axis 3 b0_pair.mif

Juntándolo todo: preprocesamiento con dwipreproc

.. code:: Bash

   dwifslpreproc sub-02_den.mif sub-02_den_preproc.mif -nocleanup -pe_dir AP -rpe_pair -se_epi b0_pair.mif -eddy_options " --slm=linear --data_is_shelled"


.. code:: Bash

   mrview sub-02_den_preproc.mif -overlay.load sub-02_dwi.mif

El siguiente código, ejecutado desde el dwidirectorio, navegará a la carpeta “tmp” y calculará el porcentaje de sectores con 
valores atípicos:

.. code::

   cd dwifslpreproc-tmp-*
   totalSlices=`mrinfo dwi.mif | grep Dimensions | awk '{print $6 * $8}'`
   totalOutliers=`awk '{ for(i=1;i<=NF;i++)sum+=$i } END { print sum }' dwi_post_eddy.eddy_outlier_map`
   echo "If the following number is greater than 10, you may have to discard this subject because of too much motion or 
   corrupted slices"
   echo "scale=5; ($totalOutliers / $totalSlices * 100)/1" | bc | tee percentageOutliers.txt
   cd ..

Generando una máscara

.. code:: Bash

   dwibiascorrect ants sub-02_den_preproc.mif sub-02_den_preproc_unbiased.mif -bias bias.mif

Ahora está listo para crear la máscara con dwi2mask, que restringirá su análisis a los vóxeles que se encuentran dentro del 
cerebro:

.. code:: Bash

   dwi2mask sub-02_den_preproc_unbiased.mif mask.mif

Compruebe la salida de este comando escribiendo:

.. code:: Bash

   mrview mask.mif

Para ello, podría usar un comando como el de FSL bet2. Por ejemplo, podría usar el siguiente código para convertir la imagen 
ponderada por difusión no sesgada al formato NIFTI, crear una máscara con bet2y luego convertirla al formato .mif:

.. code:: Bash

   mrconvert sub-02_den_preproc_unbiased.mif sub-02_unbiased.nii
   bet2 sub-02_unbiased.nii sub-02_masked -m -f 0.7
   mrconvert sub-02_masked_mask.nii.gz mask.mif

Tutorial n.º 5 de MRtrix: Deconvolución esférica restringida






