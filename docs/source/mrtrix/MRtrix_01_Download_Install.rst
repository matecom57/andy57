

.. _MRtrix_01_Descargar_Instalar:

========================================
Tutorial n.° 1 de MRtrix: Descargar e instalar
========================================

--------------

La página de descarga de `MRtrix`__ contiene instrucciones de descarga e instalación para usuarios de Windows, Macintosh y Linux. Este proceso solía ser bastante largo, ya que era necesario descargar varias dependencias y bibliotecas. Afortunadamente, los desarrolladores han creado recientemente un comando de una sola línea que lo hará todo automáticamente:


::

  sudo bash -c "$(curl -fsSL https://raw.githubusercontent.com/MRtrix3/macos-installer/master/install)"
  
Esto descargará e instalará todo el paquete MRtrix3 en su máquina, lo que no llevará más que unos pocos minutos.

Una vez descargado, abra una Terminal y escriba lo siguiente para probar su instalación:

::

  mrview
  
Esto abrirá el visor de MRtrix. En la siguiente sección, descargaremos los datos de difusión, que puede cargar en el visor haciendo clic en "Archivo -> Abrir" y seleccionando la imagen de difusión. Debería verse así:

.. figura:: 01_SampleImage.png

Intente también escribir uno de los comandos de la biblioteca, como ``mrconvert``, y presione ``Intro``. Si MRtrix se instaló correctamente, debería ver la página de ayuda impresa por defecto cuando no se pasan argumentos al comando:

.. figura:: 01_MRconvert.png

Si ambos funcionan sin errores, estará listo para comenzar a descargar datos de difusión, que abordaremos en el próximo capítulo.

Video
*****

Puedes encontrar un videotutorial para la instalación en Macintosh `aquí`__.

   

