

.. _MRtrix_Introducción:

======================
Introducción a MRtrix
======================

.. cifra::

   Ejemplo_MRtrix_Output.png

---------

¿Qué es MRtrix?
***************


MRtrix es un paquete de software para analizar datos de difusión. Una de las ventajas notables de MRtrix sobre las técnicas de ajuste de tensores es su método de **deconvolución esférica restringida**, o CSD; este método deconvoluciona la señal de difusión en cada vóxel en una serie de haces de fibras superpuestos. Esto reduce el problema del cruce de fibras, que puede ser un factor de confusión al ajustar un tensor.

Además de una biblioteca de comandos creada por el equipo de MRtrix, el software también incluye contenedores para los comandos utilizados con FSL, en particular, los comandos ``topup`` y ``eddy``. Si aún no lo ha hecho, descargue e instale el paquete de software fMRI :doc:`FSL`.

.. nota::

   Este curso se basa en los pasos descritos en la documentación de MRtrix`__, especialmente los capítulos "Preprocesamiento DWI" y "Deconvolución esférica restringida". Varios de los pasos y explicaciones se derivan del excelente tutorial de `BATMAN` de Marlene Tahedl. 
    `__, y en muchos lugares uso su notación de archivo. También quiero agradecer a John Plass, del laboratorio David Brang de la Universidad de Michigan, por compartir sus scripts conmigo y responder a mis preguntas.


Objetivos de este curso
*****************

Este curso te enseñará los fundamentos de la difusión: cómo se recopila y cómo se analiza. Aprenderás a realizar análisis basados en fixels para cuantificar la densidad de fibras de materia blanca dentro de cada vóxel y a crear tractogramas mediante tractografía probabilística. Finalmente, aprenderás a crear conectomas y a visualizar la cantidad de fibras que conectan distintas regiones cerebrales.

.. toctree::
   :maxdepth: 1
   :caption: Pasos de preprocesamiento

   MRtrix_00_Diffusion_Overview
   MRtrix_01_Download_Install
   MRtrix_02_DataDownload
   MRtrix_03_DataFormats
   MRtrix_04_Preprocessing
   MRtrix_05_BasisFunctions
   MRtrix_06_TissueBoundary
   MRtrix_07_Streamlines
   MRtrix_08_Connectome
   MRtrix_09_Scripting
   MRtrix_10_GroupAnalysis
   MRtrix_11_FixelBasedAnalysis

   

   

