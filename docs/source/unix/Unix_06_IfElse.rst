

.. _Unix_06_IfElse:

.. nota

  Temas tratados: condicionales, declaraciones if/else
  
  Comandos cubiertos: if/else, -e, !-e, elif
  
.. nota

  17/05/2019 Por el momento, esto es solo una transcripción del guión del video; eliminaré algunos de estos ejemplos del video y los mantendré aquí.

=============
Tutorial de Unix n.º 6: Declaraciones condicionales
=============

En este punto, comenzaremos a usar nuestros comandos Unix con datos de fMRI. Haga clic aquí.Para obtener instrucciones sobre cómo descargar el conjunto de datos Flanker, instalar FSL y qué es la extracción de cráneos, consulte este tutorial. Al terminar, vuelva a él.

El video anterior sobre bucles for nos mostró cómo ejecutar muchos bloques de código con ligeras modificaciones entre cada ejecución. Pero ¿qué pasa si solo queremos ejecutar el código si se cumplen ciertas condiciones? Podemos automatizar estas decisiones con **declaraciones condicionales**, también llamadas sentencias if-else: SI una condición es verdadera, ENTONCES se realiza una acción; si la condición no es verdadera, se realiza otra acción.

Por ejemplo, podríamos consultar el directorio anatómico para ver si la imagen anatómica ha sido despojada del cráneo. Si no lo ha sido, se realiza la despojada; si ya lo ha sido, no se hace nada.

Acceda al directorio anatómico sub-01. Desde la línea de comandos, escriba:

::

  si [[ -e sub-01_T1w_brain_f02.nii.gz ]]; entonces
  	eco “Existe el cerebro despojado del cráneo”
  fi

Al igual que los bucles for, una sentencia if-else consta de tres secciones distintas. La primera sección comienza con la palabra "if" y evalúa o comprueba si la sentencia entre paréntesis es verdadera o falsa. Dentro de los paréntesis, la -e significa "comprobar si este archivo existe". Si anat_brain.nii.gz existe, la sentencia ejecuta el código del cuerpo de la sentencia condicional. Puede tener tantas líneas de código en el cuerpo como desee. La última línea, fi (o "if" escrito al revés), finaliza la sentencia condicional y ejecuta el código que se indique posteriormente.

NOTA: El formato de la sentencia if-else debe ser exacto: por ejemplo, se necesita exactamente un espacio entre el primer corchete y la -e. Si no se formatea así, se generará un error.

Tenga en cuenta que si escribió la sentencia condicional anterior, no ocurrió nada. Esto se debe a que, en este caso, la sentencia se evaluó como FALSO: ese archivo no existe, por lo que el código no se ejecuta. Si queremos hacer algo si la sentencia condicional es falsa, necesitamos agregar otra sección: una sección ELSE, que se ve así:

::

	si [[ -e sub-01_T1w_brain_f02.nii.gz ]]; entonces
		eco “Existe el cerebro despojado del cráneo”
	demás
		eco “El cerebro despojado del cráneo no existe”
	fi

Esto significa que si esta sentencia condicional es verdadera, se ejecuta este bloque de código (resaltado). Si no lo es, se ejecuta este bloque de código (resaltado).

Puedes usar múltiples condicionales para dar más flexibilidad a tu sentencia if/else. Por ejemplo, supongamos que queremos comprobar si la imagen con el cráneo despojado existe. Si no existe, se evalúa si la imagen anatómica original existe. Si esta tampoco existe, se imprime que ni la imagen con el cráneo despojado ni la imagen anatómica original existen. Esto requiere una sentencia elif, que significa "else, if".

::

	si [[ -e sub-01_T1w_brain_f02.nii.gz ]]; entonces
		eco “Existe el cerebro despojado del cráneo”
	elif [[ -e sub-01_T1w.nii.gz ]]; entonces
		eco “Existe un cerebro anatómico original”
	demás
		eco “Ni el cerebro despojado del cráneo ni el cerebro original existen”
	fi

Puedes usar otras expresiones lógicas para evaluar si las afirmaciones son verdaderas o falsas. Por ejemplo, dentro de los corchetes, puedes usar un par de símbolos & para comprobar si ambos archivos existen:

::

	si [[ -e sub-01_T1w.nii.gz && -e sub-01_T1w_f02_brain.nii.gz ]]; entonces
		echo “Ambos archivos existen”
	demás
		echo “Uno o más archivos no existen”
	fi

O puedes usar un par de tuberías verticales para comprobar si existe un archivo O el otro:

::

	si [[ -e sub-01_T1w.nii.gz || -e sub-01_T1w_f02_brain.nii.gz ]]; entonces
		echo “Al menos uno de los archivos existe”
	demás
		echo “Ninguno de los archivos existe”
	fi

También puedes comprobar si un archivo NO existe colocando un signo de exclamación antes de la opción -e:

::

	si [[ ! -e sub-01_T1w_f02_brain.nii.gz ]]; entonces
		eco “El cerebro despojado del cráneo no existe”
	demás
		eco “El cerebro despojado del cráneo sí existe”
	fi

Por ahora, terminaremos con una demostración de cómo combinar un bucle for con una sentencia if/else. Supongamos que queremos comprobar si los sujetos 1, 2 y 3 tienen una imagen anatómica con el cráneo desprovisto. Si no existe, desprovisto el cráneo con bet2. Diríjase al directorio que contiene todos los sujetos y ejecute el siguiente código:

::

	para i en sub-01 sub-02 sub-03; hacer
		cd ${i}/anat
		si [[ ! -e ${i}_T1w_f02_brain.nii.gz ]]; entonces
			eco “El cerebro despojado del cráneo no existe; despojar el cerebro con un umbral de intensidad fraccionaria de 0,2”
			apuesta2 ${i}_T1w.nii.gz ${i}_T1w_f02_brain.nii.gz -f 0.2
		demás
			eco “El cerebro despojado del cráneo ya existe; no hace nada”
		fi
		cd ../..
	hecho

Esto accederá al directorio anatómico de cada sujeto y comprobará si la imagen con el cráneo desprovisto existe. De no ser así, ejecute "bet" para desprovisto el cráneo de la imagen anatómica. Los comandos "echo" son opcionales; prefiero incluirlos para que el usuario sepa qué comando se está ejecutando.

En este tutorial cubrimos muchos conceptos, pero con el tiempo y la práctica aprenderás a integrar bucles for y sentencias condicionales en tu código. El siguiente tutorial te mostrará cómo escribir todos estos comandos en un script, lo que hará que tu código sea más portátil y fácil de editar.


----------


Ceremonias
*******



--------


Video
********

Haga clic aquí
    `__ para un video que demuestra cómo escribir declaraciones condicionales.

    
   

