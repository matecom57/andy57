Tutorial n.º 2 de FreeSurfer: Cómo descargar e instalar
===================================================

-----------

Descargando FreeSurfer
**********************

Página de instalación de FreeSurfer`__ proporciona instrucciones detalladas sobre cómo descargar e instalar el paquete FreeSurfer. Esto incluye el registro de una licencia, que deberá colocar en el directorio de FreeSurfer para poder usar el software.

Cuando haya terminado de descargar e instalar el paquete, utilizará :ref:`freeview
    Para comprobar si el software se instaló correctamente. Abordaremos funciones más avanzadas de Freeview en un tutorial posterior.

.. nota::

  FreeSurfer está diseñado para sistemas operativos Unix y Macintosh. Es posible que exista una manera de instalar FreeSurfer en Windows mediante un emulador de Unix, pero no existe documentación sistemática en el sitio web de FreeSurfer que muestre cómo hacerlo. Consulte aquí.
     `__ para los conceptos básicos de una instalación de Windows.
  
  
Descargar el conjunto de datos de ejemplo
*******************************

Para el resto de nuestros tutoriales, utilizaremos un conjunto de datos de openneuro.org
      `__ que contiene exploraciones anatómicas de consumidores de cannabis y controles. Se trata de un estudio longitudinal con dos puntos temporales: una exploración basal y una de seguimiento, y mediciones de diferencias individuales como la edad y el sexo. Esto nos permitirá realizar diversos tipos de análisis, como comparaciones de grupos, análisis longitudinales y correlaciones de diferencias individuales con mediciones de materia gris. Descargue el conjunto de datos y descomprímalo haciendo doble clic en el archivo. Luego, cambie el nombre de la carpeta escribiendo ``mv ds000174-1.0.1 Cannabis``.

El conjunto de datos contiene un grupo de 20 fumadores de cannabis y un grupo de 22 controles (es decir, personas que nunca han fumado cannabis). Los sujetos cuyo ID numérico empieza por "1" pertenecen al grupo de cannabis, y los sujetos cuyo ID numérico empieza por "2" o "3" pertenecen al grupo de control. Por ejemplo, un nivel inferior a 108 pertenecería al grupo de cannabis y uno inferior a 320, al grupo de control.

El directorio de cada sujeto contiene dos subdirectorios denominados «ses-BL», que indica la sesión de referencia, y «ses-FU», que indica la sesión de seguimiento. Dentro de cada una de estas carpetas hay otro subdirectorio llamado «anat», que contiene el análisis anatómico de esa sesión. Para explorar la organización del conjunto de datos, diríjase al directorio Cannabis y escriba el siguiente comando:

::

  ls sub-112/ses-BL/anat
  
.. advertencia::

  Al probar la instalación con el comando mri_convert, podría aparecer un error como este: ``mir_convert.bin: error al cargar bibliotecas compartidas: libgomp.so.1: no se puede abrir el archivo de objeto compartido``. En ese caso, intente instalar libgomp manualmente con el comando ``sudo apt-get install libgomp1``. Además, si aparece el error ``/home/$USERNAME/freesurfer/license.txt existe, pero no tiene permiso de lectura``, intente escribir: ``chmod a+r /home/$USERNAME/freesurfer/license.txt``.

Próximos pasos
*********

Ahora que ha descargado FreeSurfer y algunos datos de ejemplo, está listo para aprender sobre el comando **recon-all** de FreeSurfer, que procesa un conjunto de datos de principio a fin. Haga clic en el botón "Siguiente" para saber más sobre su funcionamiento.

-------
  
Video
*****

Para ver un video tutorial que le muestra cómo descargar e instalar FreeSurfer, haga clic aquí
       `__.

       
      
     
    
   

