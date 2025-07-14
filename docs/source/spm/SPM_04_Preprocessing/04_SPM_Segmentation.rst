

.. _04_SPM_Segmentación:

=======================
Capítulo 4: Segmentación
=======================

-------------

Mapas de probabilidad de tejidos
***********************

El cerebro se compone de dos tipos principales de tejido: la materia gris (que contiene altas densidades de neuronas amielínicas) y la materia blanca (que contiene altas densidades de neuronas mielínicas). El cerebro también está rodeado de líquido cefalorraquídeo (LCR), y grandes cantidades de LCR se encuentran en los ventrículos, espacios internos del cerebro.

Saber qué vóxeles pertenecen a cada tipo de tejido puede ayudar a normalizar la imagen anatómica, deformándola para que coincida con una plantilla en el espacio estandarizado. SPM cuenta con imágenes de seis a priori de tejido que representan su mejor estimación de qué vóxel en el espacio estandarizado pertenece a cada tipo de tejido. Mapear con precisión los tejidos de nuestra imagen anatómica con los tejidos de la plantilla aumentará la precisión de nuestro registro.

¿Por qué seis a priori, en lugar de los tres que acabamos de mencionar? La imagen anatómica también incluye tejidos no cerebrales, como tejido blando (p. ej., duramadre) y cráneo. Este último tipo de tejido se reserva para todos los demás tejidos no capturados por ninguno de los anteriores; por lo general, esto solo significa aire dentro de los senos paranasales y fuera del cerebro, pero también puede detectar tejido anormal, como tumores.

.. figura:: 04_04_TiposDeTejido.png

  Los valores a priori de tejido de SPM, ubicados en el archivo ``spm12/tpm/TPM.nii``, son, de izquierda a derecha en cada fila: materia gris; materia blanca; LCR; tejido blando; hueso; otros.
  
Para configurar el paso de Segmentación, solo se requiere el archivo anatómico corregistrado como entrada. Haga clic en el botón "Segmentación" en la interfaz gráfica de usuario de SPM y haga doble clic en el campo "Volúmenes". Seleccione el archivo "rsub-08_T1w.nii" y configure el campo "Guardar corrección de sesgo" de "No guardar nada" a "Guardar corrección de sesgo". Finalmente, en la parte inferior del menú, cambie "Campos de deformación" a "Avanzar". A continuación, haga clic en el botón verde "Ir".

.. figura:: 04_04_Segmentación_GUI.png

Una vez finalizada la segmentación, ya está listo para usar la información generada en este paso para la **Normalización**. A continuación, nos ocuparemos de ello.

