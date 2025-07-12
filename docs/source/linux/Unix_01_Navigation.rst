

.. _Unix_01_Navegación:

===============================================
Tutorial de Unix n.º 1: Navegación por el árbol de directorios
===============================================

.. nota::
    Temas tratados: Directorios, navegación
    
    Comandos utilizados: pwd, cd, ls


Descripción general
--------

Al igual que otros sistemas operativos, Unix organiza carpetas y archivos mediante un árbol de directorios, también conocido como jerarquía de directorios o estructura de directorios. En la cima de la jerarquía se encuentra una carpeta llamada "raíz", escrita con una barra diagonal (``/``). Todas las demás carpetas (también conocidas como directorios) se encuentran dentro de la carpeta "raíz", y estas carpetas, a su vez, pueden contener otras carpetas.

Piense en la jerarquía de directorios como un árbol al revés: la raíz es la base del árbol y todas las demás carpetas se extienden desde ella, así como las ramas se extienden desde el tronco.

.. figure:: UnixTree.png

    La raíz, simbolizada por una barra diagonal (``/``), es el nivel superior del árbol de directorios. Contiene carpetas como ``bin`` (que contiene archivos binarios o comandos de Unix como pwd, cd, ls, etc.), ``mnt`` (que muestra las unidades actualmente montadas, como discos duros externos) y ``Usuarios``. Estos directorios, a su vez, contienen otros directorios; por ejemplo, ``Usuarios`` contiene la carpeta ``andrew``, que a su vez contiene los directorios ``Escritorio``, ``Aplicaciones`` y ``Descargas``. Así es como se organizan las carpetas y los archivos dentro de un árbol de directorios.
    

Para navegar por tu ordenador, necesitarás conocer los comandos ``pwd``, ``cd`` y ``ls``. ``pwd`` significa "imprimir directorio de trabajo"; ``cd`` significa "cambiar directorio"; y ``ls`` significa "listar", como en "mostrar el contenido del directorio actual". Esto es similar a señalar y hacer clic en una carpeta del escritorio y ver su contenido. Ten en cuenta que en estos tutoriales, los términos "carpeta" y "directorio" se usan indistintamente.

.. figure:: Carpeta_de_escritorio.png

    Navegar en Unix es como apuntar y hacer clic en una interfaz gráfica de usuario típica. Por ejemplo, si tienes la carpeta "ExperimentFolder" en mi escritorio, puedes apuntar y hacer doble clic para abrirla. Puedes hacer lo mismo escribiendo ``cd ~/Desktop/ExperimentFolder`` en la Terminal y luego escribiendo ``ls`` para ver el contenido del directorio.


Video
-----

Haga clic aquí`__ para ver un video con una descripción general de los comandos cd, ls y pwd: los comandos básicos que necesitará para navegar por su árbol de directorios.


-------------

Ceremonias
---------

Cuando termines de ver el vídeo, prueba los siguientes ejercicios:

1. Escriba ``ls ~`` y observe el resultado; luego escriba ``ls ~/Desktop``. ¿En qué se diferencian los resultados? ¿Por qué?

2. Vaya al Escritorio escribiendo ``cd ~/Desktop``. Escriba ``pwd`` y anote la ruta. Luego, cree un nuevo directorio con el comando ``mkdir``, eligiendo un nombre para el directorio. Vaya a ese nuevo directorio y observe cómo se ha actualizado su ruta actual. ¿Coincide con lo que ve al escribir ``pwd`` desde el nuevo directorio?

3. Define los términos «cd», «ls» y «pwd» con tus propias palabras.

   


