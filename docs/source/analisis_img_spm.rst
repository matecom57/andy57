Analisis imagenes con SPM
=========================

Una vez descargado el paquete SPM, colóquelo en su directorio personal. Abra Matlab, haga clic en la pestaña "Inicio" y 
luego en el botón "Establecer ruta". Seleccione el spm12directorio y haga clic en "Agregar con subcarpetas". Haga clic en 
el botón "Guardar" para asegurarse de que la ruta se configure cada vez que abra Matlab y cierre la ventana.

.. code:: Bash

   spm

SPM Tutorial #3: Looking at the Data
------------------------------------

.. code:: Bash

   movefile('~/Downloads/ds000102_0001/', 'Flanker')

Inspecting the Anatomical Image
-------------------------------

To begin, let’s take a look at the anatomical image in the anat folder for sub-08. If you haven’t already opened SPM, 
navigate to the sub-08 folder and then type

.. code:: Bash

   spm fmri

SPM can read any image that are in NIFTI format, but they cannot be compressed - that is, if the datasets end with a .gz 
extension, you will first need to unzip them by navigating to the directory containing the images and then type

.. code:: Bash

   gunzip('*.gz')

SPM Tutorial #4: Preprocessing
------------------------------

To begin preprocessing sub-08’s data, read through the following chapters. We will begin with Realignment and Slice-Timing 
Correction, which correct misalignments and timing errors in the functional images, before moving on to Coregistration and 
Normalization, which align the functional and structural images and move them both to a standardized space. Finally, the 
images are Smoothed in order to increase signal and cancel out noise. The typical sequence of preprocessing steps is 
numbered in the image below:


Capítulo 1: Realinear y corregir la distorsión de los datos
-----------------------------------------------------------

Al hacer clic en el botón , se abre una ventana con las opciones para realinear y redividir los datos. Esta sección se 
refiere a la estimación del grado de desalineación de cada volumen con respecto a un volumen de referencia e indica que 
estas estimaciones se utilizarán para ajustar cada volumen a su nivel de referencia. El volumen de referencia se define en 
el campo "Número de pasadas", que permite especificar si los volúmenes se alinearán con la media de todos los volúmenes o 
con el primero. Para este tutorial, deje este valor predeterminado y los demás valores predeterminados sin 
modificar.Realign (Estimate & Reslice)EstimateReslice

Loading the Images
------------------

In this experiment, there were two runs of data per subject (SPM refers to each run as a session). If you click on the Data 
field, you will see an option to add more sessions. Click on New: Session to add another session. You will see an <-X to 
the right of each Session field, indicating that this field needs to be filled in before the program can be run.

Double-click on the first session to open up the Image Selection window. Navigate to the func directory and select the file 
sub-08_task-flanker_run-1_bold.nii,1. The ,1 at the end of the file name indicates that only the first frame, or volume, is 
available for selection. In order to select all of the volumes for that run, we will need to expand the number of frames 
available for selection. In the Frames field (underneath the Filter field), type 1:146 and press enter.



If you don’t know how many frames are in the current dataset, you can set the upper bound to an arbitrarily high number - 
e.g., 1:10000. The list of files will max out at the number of available frames, and so will ensure that you do not miss 
any.

When you are finished, click Done. Do the same procedure for the second session, using the Filter field to restrict your 
search to frames containing the string run-2.

Chapter 2: Slice-Timing Correction
----------------------------------

Doing Slice-Timing Correction in SPM
------------------------------------

Similar to what we did with Realignment, we will first click on the Slice Timing button in the SPM GUI. Click on the Data 
field and create two new Sessions. Double-click on the first Session, and in the Filter column type 
^rsub-08_task-flanker_run-1.*. In the Frames field, enter 1:146 and press enter; select all of the frames that are 
displayed, and click Done. Do the same procedure for the run-2 files for the second session.

For the Number of Slices field, we will need to find out how many slices there are in each of the volumes in our dataset. 
From the Matlab terminal navigate to the directory sub-08/func and type:

.. code:: Bash

   V = spm_vol('sub-08_task-flanker_run-1_bold.nii')

Chapter 3: Coregistration
-------------------------

Co-registration with SPM
------------------------

To co-register the functional and anatomical images, go back to the SPM GUI and click on Coregister (Estimate & Reslice). 
This will open up a batch editor window with only two fields that need to be filled in - a Reference Image and a Source 
Image.

Double-click on the Reference Image, and select the meansub-08_task-flanker_run-1_bold.nii. For the source image, navigate 
to the anat directory and select the file sub-08_T1w.nii. Then click the green Go button. This step should only take a few 
moments.

Chapter 4: Segmentation
-----------------------

Setting up the Segmentation step only requires the coregistered anatomical file as input. Click on the Segmentation button 
from the SPM GUI, and double-click the Volumes field. Select the file rsub-08_T1w.nii, and then set the Save Bias Corrected 
field from Save Nothing to Save Bias Corrected. Lastly, at the very bottom of the menu, change Deformation Fields to 
Forward. Then click the green Go button.

Chapter 5: Normalization
------------------------

Chapter 6: Smoothing
--------------------

How to Smooth in SPM
--------------------

In the SPM GUI, click on the Smooth button and double-click on Images to Smooth. Select the warped functional images, and 
expand them to include all 146 frames for each run. (See the previous chapters for examples on how to use the Filter and 
Frames fields to select the images that you want.) Leave the other defaults as they are, and then click on the green Go 
button.

SPM Tutorial #5: Statistics and Modeling
----------------------------------------

Chapter 1: The Time-Series

Chapter 2: History of the BOLD Signal

Chapter 3: The Hemodynamic Response Function (HRF)

Chapter 4: The General Linear Model
-----------------------------------

Chapter 5: Creating Timing Files
--------------------------------

Chapter 6: Running the First-Level Analysis
-------------------------------------------

Specifying the Model
--------------------

Having created the timing files in the previous chapter, we can use them in conjunction with our imaging data to create 
statistical parametric maps. These maps indicate the strength of the correlation between our ideal time-series (which 
consists of our onset times convolved with the HRF) and the time-series that we collected during the experiment. The amount 
of modulation of the HRF is represented by a beta weight, and this in turn is converted into a t-statistic when we create 
contrasts using the SPM contrast manager.

To begin, from the SPM GUI click on Specify 1st-Level. Note that the first field that needs to be filled in is the 
Directory field. To keep our results organized, go to the Matlab terminal, navigate to the sub-08 directory, and type mkdir 
1stLevel. Then double-click on Directory and select the 1stLevel directory you just created. All of the output of the 
1st-level analysis will go into this folder.


Next, we will fill in the Timing parameters section. Under Units for design, select Seconds, and enter a value of 2 for 
Interscan Interval. Then click on Data & Design, and click twice on New: Subject/Session to create two new sessions. For 
the Scans of the first session, go to the func directory and use the Filter and Frames fields to select all 146 volumes of 
the warped functional data (i.e., those files beginning with swar). Do the same for the volumes in the second session.

Go back to the field for the first session. There are two conditions in the experiment, and both conditions occur in each 
run. Click on Conditions and then New: Condition twice to create two new Condition fields. For the first condition, 
double-click on Name and type Inc.

We will now need the onset times for each occurrence of the Incongruent condition. From the Matlab terminal, navigate to 
the func directory and type:

.. code:: Bash

   IncRun1 = importdata('incongruent_run1.txt');
   IncRun1(:,1)

Which will return the onset times for the Incongruent condition of run 1. Double-click on the Onsets field, and copy and 
paste the onset times into the window. Click Done.

In this experiment each trial lasted for 2 seconds. We can therefore enter the number 2 in the Durations field, and SPM 
will assume that it is the same duration for every trial.

Now do the same procedure for the Congruent condition for run 1, and the Incongruent and Congruent conditions for run 2, 
remembering to enter a duration value of 2 for all of them. Here is the code to display the onset times for each of the 
remaining onset times that you will need:

.. code:: Bash

   ConRun1 = importdata('congruent_run1.txt');
   ConRun1(:,1)
   IncRun2 = importdata('incongruent_run2.txt');
   IncRun2(:,1) 
   ConRun2 = importdata('congruent_run2.txt');
   ConRun2(:,1)

Estimating the Model
---------------------

Now that we have created our GLM, we will need to estimate the beta weights for each condition. From the SPM GUI click 
Estimate, and then double-click on the field Select SPM.mat. Change the Write residuals option to Yes. Navigate to the 
1stLevel directory and select the SPM.mat file, and then click the green Go button. This will take a few minutes to run.

The Contrast Manager
--------------------

To create these contrasts, click on the Results button of the SPM GUI, and select the SPM.mat file that was generated after 
estimating the model. You will see the design matrix on the right side of the panel. Click on Define New Contrast, and in 
the Name field type Inc-Con. In the contrast vector window, type 0.5 -0.5 0.5 -0.5, and then click submit. If the contrast 
is valid, you should see green text at the bottom of the window saying “name defined, contrast defined”. Make sure that 
your contrast manager looks like the figure below, and then click OK to create the contrast.

Examining the Output
--------------------



