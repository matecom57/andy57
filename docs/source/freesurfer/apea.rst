Apéndice A: Índice de girificación local
====================================

Analizando el tema
*********************

El Índice de Girificación Local (IGL) mide el plegamiento cortical. Por ejemplo, una región del cerebro con más involuciones en un espacio más pequeño, como la circunvolución frontal inferior, tendrá un IGL mayor que una región con menos pliegues corticales. Una vez procesado un sujeto mediante recon-all, se puede calcular un mapa del IGL de todo el cerebro.

Sin embargo, FreeSurfer por sí solo no puede generar un mapa LGI; primero deberá instalar Matlab, junto con su `Image Processing Toolbox`.`__. Una vez instalado, deberá configurar la ruta para que apunte a su Matlab. En mi caso, escribí:

::

  exportar PATH=/Aplicaciones/MATLAB_R2021b.app/bin:${PATH}
  
Luego, escribe ``getmatlab`` para asegurarte de que la ruta se haya configurado correctamente. De ser así, deberías ver la ruta devuelta al símbolo del sistema.

Para ejecutar el análisis LGI, escriba:

::

  recon-all -s
    -localGI
  
Reemplazar ``
     `` con el ID del sujeto que desea analizar. Por ejemplo, si tengo un sujeto con el ID 29161 y ya lo he analizado con recon-all, primero iría al directorio que lo contiene y establecería la ruta SUBJECTS_DIR si aún no lo he hecho. Luego, ejecutaría el comando -localGI:

::

  cd Directorio que contiene temas
  SUBJECTS_DIR=`pwd`
  recon-all -s 29161 -localGI


Esto tardará un par de horas. Al finalizar, verás nuevos archivos en el directorio ``surf`` con la extensión ``_lgi``:

.. figura:: ApéndiceA_LGI_Output.png


Visualización de los resultados
*******************

Luego puede ver los resultados usando "freeview" con la opción Superposición. Por ejemplo, si desea cargar los resultados de LGI desde la línea de comandos para el hemisferio izquierdo, puede escribir lo siguiente:

::

  freeview -f 29161/surf/lh.inflado:superposición=lh.pial_lgi
  
Lo cual debería mostrarte algo como esto:

.. figura:: ApéndiceA_LGI_Freeview.png

La configuración predeterminada es mostrar los resultados de LGI como un mapa de calor; sin embargo, puede resultar más útil mostrarlos como una rueda de color. Haga clic en el botón "Configurar" para abrir una nueva ventana con el rango de intensidad de la superposición. En el panel "Escala de color", seleccione el botón "Rueda de color"; también marque la casilla junto a "Invertir". Esto mostrará las intensidades más altas como más rojas y las más bajas como tonos de azul. También puede mover las flechas verde y roja para encontrar el rango de intensidad que mejor se adapte a sus necesidades.

.. figura:: ApéndiceA_LGI_ColorWheel.png


Análisis del ROI
************

Al igual que hicimos con el análisis de ROI para mediciones como espesor y volumen, puede extraer resultados de LGI de las parcelaciones proporcionadas por FreeSurfer. Por ejemplo, desde el directorio que contiene los sujetos ya analizados con LGI, escriba:

::

  mri_segstats --annot 29161 lh aparc --i 29161/surf/lh.pial_lgi --suma lh.aparc.pial_lgi.stats
  
Esto generará un nuevo archivo, ``lh.aparc.pial_lgi.stats``, que contiene los resultados de LGI, medidos en milímetros cuadrados, para cada una de las parcelaciones:

.. figura:: ApéndiceA_LGI_ROI_Stats.png

Estos datos pueden luego usarse para realizar comparaciones grupales y correlacionarse con diferencias individuales.

     
    
   

