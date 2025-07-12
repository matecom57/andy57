

.. _Unix_09_Automatizando el análisis:

Tutorial de Unix n.° 9: Automatización del análisis
==================

----------------

Descripción general
*********

Al comenzar este tutorial, nos hemos fusionado completamente con el curso fMRI asociado :ref:``. La mayor parte del texto aquí está tomado del capítulo fMRI sobre :ref:`scripting 
    `, que utiliza todos los comandos que hemos aprendido. La siguiente sección le mostrará cómo integrar condicionales, bucles for y sed para integrar líneas de código independientes en un script útil.

Ejecutar el script
*********

El código a continuación está diseñado para editar y ejecutar un archivo que analiza cada sujeto del conjunto de datos Flanker. Una vez creada la plantilla
     `__, mueva los archivos design_run1.fsf y design_run2.fsf al directorio que contiene sus asignaturas (es decir, ``mv design*.fsf ..``, y luego ``cd ..``). Luego descargue el script `run_1stLevel_Analysis.sh`. 
      `__ y muévelo al directorio Flanker. El script se reproduce aquí:

::

  #!/bin/bash

  # Generar la lista de temas para poder modificar este script
  # para ejecutar sólo un subconjunto de temas más fácilmente.

  para id en `seq -w 1 26` ; hacer
      subj="sub-$id"
      echo "===> Iniciando procesamiento de $subj"
      eco
      cd $subj

          # Si la máscara cerebral no existe, créala
          si [ ! -f anat/${subj}_T1w_brain_f02.nii.gz ]; entonces
              bet2 anat/${subj}_T1w.nii.gz \
                  echo "No se encontró cerebro desprovisto de cráneo, utilizando bet con un umbral de intensidad fraccionaria de 0,2" \
                  anat/${subj}_T1w_brain_f02.nii.gz -f 0.2 #Nota: Esta intensidad fraccionaria parece funcionar bien para la mayoría de los sujetos del conjunto de datos Flanker. Puede que desee cambiarla si modifica este script para su propio estudio.
          fi

          # Copie los archivos de diseño en el directorio del tema y luego
          # cambiar “sub-08” al número de asunto actual
          cp ../design_run1.fsf .
          cp ../design_run2.fsf .

          # Tenga en cuenta que estamos usando el carácter | para delimitar los patrones
          # en lugar del carácter / habitual porque hay caracteres /
          # en el patrón.
          sed -i '' "s|sub-08|${subj}|g" \
              diseño_run1.fsf
          sed -i '' "s|sub-08|${subj}|g" \
              diseño_run2.fsf

          # Ahora todo está configurado para ejecutar la hazaña
          echo "===> Hazaña inicial para la carrera 1"
          hazaña design_run1.fsf
          echo "===> Hazaña inicial para la carrera 2"
          hazaña design_run2.fsf
                  eco

      # Regrese al directorio que contiene todos los temas y repita el bucle
      cd ..
  hecho

  eco

Analizando el guión
*********

Repasemos cada parte de este script y describamos lo que hace.

Inicializando el bucle for
^^^^^^^^^^

Comienza con un shebang y algunos comentarios que describen la función exacta del script. Luego, se usan comillas invertidas para expandir ``seq -w 1 26`` y crear un bucle que ejecute el cuerpo del código en todos los sujetos. Esto se expandirá a ``01, 02, 03 ... 26`` y actualizará el número asignado a la variable ``id`` en cada iteración del bucle.

::

  #!/bin/bash

  # Generar la lista de temas para poder modificar este script
  # para ejecutar sólo un subconjunto de temas más fácilmente.

  para id en `seq -w 1 26` ; hacer
      subj="sub-$id"
      echo "===> Iniciando procesamiento de $subj"
      eco
      cd $subj


Por ejemplo, el primer bucle de este código asignará la cadena ``sub-01`` a la variable ``subj`` y, a continuación, repetirá "===> Iniciando procesamiento de sub-01". A continuación, accederá al directorio ``sub-01``.


Condicionales para comprobar la anatomía del cráneo despojado
^^^^^^^^^^

A continuación, el script utiliza una condición para verificar si existe la anatomía sin cráneo y, si no existe, se genera la imagen sin cráneo.

::

          # Si la máscara cerebral no existe, créala
          si [ ! -f anat/${subj}_T1w_brain_f02.nii.gz ]; entonces
              bet2 anat/${subj}_T1w.nii.gz \
                  echo "No se encontró cerebro desprovisto de cráneo, utilizando bet con un umbral de intensidad fraccionaria de 0,2" \
                  anat/${subj}_T1w_brain_f02.nii.gz -f 0.2 #Nota: Esta intensidad fraccionaria parece funcionar bien para la mayoría de los sujetos del conjunto de datos Flanker. Puede que desee cambiarla si modifica este script para su propio estudio.
          fi
      
      
Edición y ejecución del archivo de plantilla
^^^^^^^^^^

A continuación, se edita el archivo *.fsf de diseño de plantilla para reemplazar la cadena ``sub-08`` con el nombre del sujeto actual. Los archivos *.fsf se ejecutan con el comando ``feat``, que es como ejecutar la interfaz gráfica de FEAT desde la línea de comandos. Se utilizan comandos de eco en todo el script para avisar al usuario cuando se ejecuta un nuevo paso.

::

          # Copie los archivos de diseño en el directorio del tema y luego
          # cambiar “sub-08” al número de asunto actual
          cp ../design_run1.fsf .
          cp ../design_run2.fsf .

          # Tenga en cuenta que estamos usando el carácter | para delimitar los patrones
          # en lugar del carácter / habitual porque hay caracteres /
          # en el patrón.
          sed -i '' "s|sub-08|${subj}|g" \
              diseño_run1.fsf
          sed -i '' "s|sub-08|${subj}|g" \
              diseño_run2.fsf
              
           
Los archivos design.fsf, ubicados en el directorio principal de Flanker, se copian al directorio del sujeto actual. Sed reemplaza la cadena ``sub-08`` con el valor actual de ``subj`` asignado en el bucle. La última parte del código ejecuta los archivos .fsf con el comando ``feat`` e imprime en la terminal la ejecución que se está analizando.

::

          # Ahora todo está configurado para ejecutar la hazaña
          echo "===> Hazaña inicial para la carrera 1"
          hazaña design_run1.fsf
          echo "===> Hazaña inicial para la carrera 2"
          hazaña design_run2.fsf
                  eco
                  
                  
Puede ejecutar el script simplemente escribiendo ``bash run_1stLevel_Analysis.sh``. Los comandos `echo` imprimirán texto en la terminal al ejecutar un nuevo paso, y las páginas HTML registrarán el progreso del preprocesamiento y las estadísticas.

----------

Resumen
***********

En este punto, ya ha aprendido todos los comandos y conceptos de Unix necesarios para ejecutar un script de análisis de fMRI. Si es la primera vez que usa Unix, esto puede parecer complicado; pero con la práctica, comprenderá por qué el script está compuesto de esa manera y cómo, en relativamente pocas líneas, puede representar lo que puede requerir decenas de horas de trabajo.

Al invertir tiempo en aprender Unix ahora, podrá realizar sus análisis de forma más rápida, eficiente y menos propensa a errores. También espero que haya adquirido más confianza para dar los primeros pasos y aplicar sus nuevas habilidades a la escritura de sus propios scripts de análisis.


----------

Video
*********

Para ver una demostración en pantalla de cómo descargar y ejecutar el script anterior, haga clic aquí
       `__.

       
      
     
    
   

