Tutorial n.º 5 de FreeSurfer: Cómo usar la cuadrícula de ciencia abierta
===================================================

-----------

Restricciones de tiempo con Recon-All
*******************************

Incluso si puede ejecutar varios trabajos con el comando paralelo, puede que no sea práctico para conjuntos de datos muy grandes, por ejemplo, un estudio que incluya cientos de sujetos. Además, es posible que no desee tener todos sus núcleos de procesamiento ocupados en la ejecución de recon-all y prefiera tener su computadora libre para otros proyectos.

Una opción es usar una supercomputadora, disponible en la mayoría de las universidades. Si no tienes acceso a una, puedes usar una supercomputadora pública alojada por Open Science Grid.
    `__, que utiliza núcleos de procesamiento en computadoras ubicadas en más de cien sitios: laboratorios, universidades y otras instituciones. Se puede enviar un comando recon-all a Open Science Grid, que luego se distribuye a uno de los muchos núcleos disponibles. Para la mayoría de los investigadores de imágenes, prácticamente no hay límite en la cantidad de trabajos que se pueden enviar; un lote de cien o doscientos trabajos no es muy grande para los estándares de una supercomputadora, y el lote completo generalmente se puede completar en menos de una semana.


Preparación de sus datos para la Red de Ciencia Abierta
**********************************************

Antes de poder utilizar cualquiera de los recursos de Open Science Grid, debe crear una cuenta `aquí
    `__.

También necesitarás el comando ``fsurf`` para enviar todos los trabajos de reconocimiento a la supercomputadora Open Science Grid. Para descargar este comando, escribe:

::

  curl -L -o fsurf 'http://stash.osgconnect.net/+fsurf/fsurf'
  chmod +x fsurf
  
Y luego mueva el ejecutable de fsurf a un directorio al que apunte su PATH. Por ejemplo, la mayoría de los sistemas operativos tienen una ruta que, por defecto, apunta al directorio ``/bin``, el mismo directorio que contiene comandos como ``ls``, ``cd`` y ``pwd``. Si mueve ``fsurf`` a ``/bin``, podrá ejecutar el comando desde cualquier directorio:

::

  sudo mv fsurf /bin
  
.. nota::

  En el ejemplo de código anterior, se usa ``sudo`` para mover fsurf al directorio /bin. Esto se debe a que este directorio se considera confidencial: nadie debe modificarlo a menos que sepa lo que hace. Por lo tanto, ``sudo`` le solicitará su contraseña antes de mover el archivo.
  

A continuación, cree una lista de todos los temas escribiendo el siguiente código:

::

  ls | grep sub- > subjList.txt
  
Esto canalizará los resultados del comando ``ls`` a un archivo llamado subjList.txt. Luego, usaremos esta lista para crear un bucle for y enviar todos nuestros trabajos de recon-all a la supercomputadora Open Science Grid.


Envío de trabajos de Recon-All
*************************

Open Science Grid tiene un sistema particular en cuanto al modo en que se envían los trabajos: cada imagen anatómica debe empaquetarse de una manera determinada, tal como se deben empaquetar los artículos cuando se dejan en la oficina de correos.

Primero deberá ejecutar recon-all en sus imágenes anatómicas, omitiendo la opción ``-all``. Esto creará una serie de directorios y luego convertirá la imagen anatómica al formato .mgz y la colocará en el directorio ``mri/orig``. El siguiente código puede copiarse y pegarse en la terminal o copiarse en un script de shell y ejecutarse con ``tcsh``:

::

  para cada sujeto (`cat subjList.txt`)
        cd $subj/ses-BL/anat
        if (! -d $subj ) then #Si el directorio FS no existe, entonces ejecute recon-all
                recon-all -s $subj -i *.nii.gz -sd .
                #zip los directorios de FreeSurfer, para que puedan enviarse a fsurf
                zip -r $subj.zip $subj
                cd ../../..
        demás
                echo "La carpeta FreeSurfer para $subj ya existe; si desea volver a ejecutar recon-all para este sujeto, elimine la carpeta y vuelva a ejecutar este script".
                cd ../../..
        fin si
    fin


Una vez finalizado, puedes enviar los trabajos usando ``fsurf``. En este ejemplo, he colocado ``fsurf`` en un bucle for:

::

  para cada sujeto (`cat subjList.txt`)
        cd $subj/ses-BL/anat
        fsurf submit --subject=$subj --input=$subj.zip --defaced --deidentified --version 6.0.0 --freesurfer-options='-all -qcache -3T'
        cd ../../..
  fin

El estado de los trabajos se puede consultar escribiendo "fsurf list". Esto mostrará varias columnas en la pantalla. La primera columna corresponde al nombre del sujeto, la segunda al ID del sujeto asignado por la supercomputadora Open Science Grid y la penúltima especifica si el trabajo está en ejecución, se ha completado o ha fallado. Revise periódicamente el estado de estos trabajos para ver cuáles se pueden descargar.


.. nota::

  Los ejemplos de código anteriores están escritos en ``tcsh`` en lugar de ``bash``. Puedes escribirlos en cualquiera de los dos; yo estaba usando ``tcsh`` en ese momento.


Descargar o eliminar trabajos
****************************

Una vez finalizado recon-all, puedes descargar la salida escribiendo este código:

::

  Salida de fsurf --id
     
  
Donde «subjID» es el código de identificación asignado por la supercomputadora. Es el número en la segunda columna de la salida del comando «fsurf list». Los datos descargados tendrán la extensión .bz2; puede descomprimirlos escribiendo «tar xvjf».
      ``, reemplazando ``subjName`` con el nombre del conjunto de datos descargado.


Por otro lado, si deseas eliminar un trabajo en cualquier momento y por cualquier motivo, puedes hacerlo escribiendo:

::

  fsurf eliminar --id
       
  
``subjID`` se encuentra de la misma manera que arriba.


--------

.. Video
.. ********

.. Para ver cómo descargar fsurf y ejecutar trabajos en la supercomputadora Open Science Grid, mira este video
        
         `__.
        
       
      
     
    
   

