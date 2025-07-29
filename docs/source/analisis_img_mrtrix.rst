Analisis img MRtrix
===================


MRtrix Tutorial #2: Downloading the Dataset
-------------------------------------------

When the download has finished, unzip the folder, open a Terminal, and then rename it to BTC_preop:

.. code:: Bash

   mv ~/Downloads/ds001226-00001 ~/Desktop/BTC_preop

MRtrix Tutorial #3: Looking at the Data
---------------------------------------

To see how this works, navigate to the folder sub-CON02/ses-preop/dwi, which contains your diffusion data. One of the first steps for 
preprocessing your data is converting the diffusion data to a format that MRtrix understands; we will use the command mrconvert to 
combine the raw diffusion data with its corresponding .bval and .bvec files, so that we can use the combined file for future 
preprocessing steps:

.. code:: Bash

   mrconvert sub-CON02_ses-preop_acq-AP_dwi.nii.gz sub-02_dwi.mif -fslgrad sub-CON02_ses-preop_acq-AP_dwi.bvec sub-CON02_ses-preop_acq-AP_dwi.bval

To make the rest of the tutorial easier to read as well, use the mv command to rename the .bval and .bvec files:

.. code:: Bash

   mv sub-CON02_ses-preop_acq-AP_dwi.bvec sub-02_AP.bvec
   mv sub-CON02_ses-preop_acq-AP_dwi.bval sub-02_AP.bval
   mv sub-CON02_ses-preop_acq-PA_dwi.bvec sub-02_PA.bvec
   mv sub-CON02_ses-preop_acq-PA_dwi.bval sub-02_PA.bval

The output image, sub-02_dwi.mif, can be checked with the command mrinfo:

.. code:: Bash

   mrinfo sub-02_dwi.mif

Bvals and Bvecs
---------------

.. code:: Bash

   mrinfo -size sub-02_dwi.mif | awk '{print $4}'

.. code:: Bash

   awk '{print NF; exit}' sub-02_AP.bvec 
   awk '{print NF; exit}' sub-02_AP.bval

Looking at the Data with mrview
--------------------------------

.. code:: Bash

   mrview sub-02_dwi.mif

MRtrix Tutorial #4: Preprocessing
---------------------------------

dwi_denoise
-----------

.. code:: Bash

   dwidenoise sub-02_dwi.mif sub-02_den.mif -noise noise.mif

mri_degibbs
-----------

An optional preprocessing step is to run mri_degibbs, which removes Gibbs’ ringing artifacts from the data. These artifacts look like 
ripples in a pond, and are most conspicuous in the images that have a b-value of 0. Look at your diffusion data first with mrview, 
and determine whether there are any Gibbs artifacts; if there are, then you can run mrdegibbs by specifying both an input file and 
output file, e.g.:

.. code:: Bash

   mrdegibbs sub-02_den.mif sub-02_den_unr.mif

Extracting the Reverse Phase-Encoded Images
-------------------------------------------

Our first step is to convert the reverse phase-encoded NIFTI file into .mif format. We will also add its b-values and b-vectors into 
the header:

.. code:: Bash

   mrconvert sub-CON02_ses-preop_acq-PA_dwi.nii.gz PA.mif
   mrconvert PA.mif -fslgrad sub-02_PA.bvec sub-02_PA.bval - | mrmath - mean mean_b0_PA.mif -axis 3

Next, we extract the b-values from the primary phase-encoded image, and then combine the two with mrcat:

.. code:: Bash

   dwiextract sub-02_den.mif - -bzero | mrmath - mean mean_b0_AP.mif -axis 3
   mrcat mean_b0_AP.mif mean_b0_PA.mif -axis 3 b0_pair.mif

Putting It All Together: Preprocessing with dwipreproc
------------------------------------------------------

We now have everything we need to run the main preprocessing step, which is called by dwipreproc. For the most part, this command is 
a wrapper that uses FSL commands such as topup and eddy to unwarp the data and remove eddy currents. For this tutorial, we will use 
the following line of code:

.. code:: Bash

   dwifslpreproc sub-02_den.mif sub-02_den_preproc.mif -nocleanup -pe_dir AP -rpe_pair -se_epi b0_pair.mif -eddy_options " --slm=linear --data_is_shelled"

This command can take several hours to run, depending on the speed of your computer. For an iMac with 8 processing cores, it takes 
roughly 2 hours. When it has finished, examine the output to see how eddy current correction and unwarping have changed the data; 
ideally, you should see more signal restored in regions such as the orbitofrontal cortex, which is particularly susceptible to signal 
dropout:

.. code:: Bash

   mrview sub-02_den_preproc.mif -overlay.load sub-02_dwi.mif

Checking for Corrupt Slices
---------------------------

The following code, run from the dwi directory, will navigate into the “tmp” folder and calculate the percentage of outlier slices:

.. code::

   cd dwifslpreproc-tmp-*
   totalSlices=`mrinfo dwi.mif | grep Dimensions | awk '{print $6 * $8}'`
   totalOutliers=`awk '{ for(i=1;i<=NF;i++)sum+=$i } END { print sum }' dwi_post_eddy.eddy_outlier_map`
   echo "If the following number is greater than 10, you may have to discard this subject because of too much motion or corrupted 
   slices"
   echo "scale=5; ($totalOutliers / $totalSlices * 100)/1" | bc | tee percentageOutliers.txt
   cd ..

Generating a Mask
-----------------

.. code:: Bash

   dwibiascorrect ants sub-02_den_preproc.mif sub-02_den_preproc_unbiased.mif -bias bias.mif

You are now ready to create the mask with dwi2mask, which will restrict your analysis to voxels that are located within the brain:

.. code:: Bash

   dwi2mask sub-02_den_preproc_unbiased.mif mask.mif

Check the output of this command by typing:

.. code:: Bash

   mrview mask.mif

To that end, you could use a command such as FSL’s bet2. For example, you could use the following code to convert the unbiased 
diffusion-weighted image to NIFTI format, create a mask with bet2, and then convert the mask to .mif format:


.. code:: Bash

   mrconvert sub-02_den_preproc_unbiased.mif sub-02_unbiased.nii
   bet2 sub-02_unbiased.nii sub-02_masked -m -f 0.7
   mrconvert sub-02_masked_mask.nii.gz mask.mif

MRtrix Tutorial #5: Constrained Spherical Deconvolution
-------------------------------------------------------

Unlike most fMRI studies which use a basis function that has been created beforehand, MRtrix will derive a basis function from the 
diffusion data; using an individual subject’s data is more precise and specific to that subject. The command dwi2response has several 
different algorithms that you can choose from, but for this tutorial we will use the “dhollander” algorithm:

.. code:: Bash

   dwi2response dhollander sub-02_den_preproc_unbiased.mif wm.txt gm.txt csf.txt -voxels voxels.mif

Fiber Orientation Density (FOD)
-------------------------------

To do this, we will use the command dwi2fod to apply the basis functions to the diffusion data. The “-mask” option specifies which 
voxels we will use; this is simply to restrict our analysis to brain voxels and reduce the computing time. The “.mif” files specified 
after each basis function will output an FOD image for that tissue type:

.. code:: Bash

   dwi2fod msmt_csd sub-02_den_preproc_unbiased.mif -mask mask.mif wm.txt wmfod.mif gm.txt gmfod.mif csf.txt csffod.mif


.. code:: Bash

   mrconvert -coord 3 0 wmfod.mif - | mrcat csffod.mif gmfod.mif - vf.mif

The white matter FODs can then be overlaid on this image, so that we can observe whether the white matter FODs do indeed 
fall within the white matter, and also whether they are along the orientations that we would expect:

.. code:: Bash

   mrview vf.mif -odf.load_sh wmfod.mif

Normalization
-------------

To normalize the data, we will use the mtnormalise command. This requires an input and output for each tissue type, as well 
as a mask to restrict the analysis to brain voxels:

.. code:: Bash

   mtnormalise wmfod.mif wmfod_norm.mif gmfod.mif gmfod_norm.mif csffod.mif csffod_norm.mif -mask mask.mif

MRtrix Tutorial #6: Creating the Tissue Boundaries
-------------------------------------------------

Converting the Anatomical Image
-------------------------------

.. code:: Bash

   mrconvert ../anat/sub-CON02_ses-preop_T1w.nii.gz T1.mif

This creates a new file, T1.mif, which you can look at in mrview.

We will now use the command 5ttgen to segment the anatomical image into the tissue types listed above:

.. code:: Bash

   5ttgen fsl T1.mif 5tt_nocoreg.mif

If the segmentation step fails, this may be due to insufficient contrast between the tissue types; for example, some 
anatomical images are either very dark across both the grey and white matter, or very light across both tissue types. We 
can help the segmentation process by increasing the intensity contrast (also known as intensity normalization) between the 
tissues with a command like AFNI’s 3dUnifize, e.g.:

.. code:: Bash

   3dUnifize -input anat.nii -prefix anat_unifize.nii

Coregistering the Diffusion and Anatomical Images
-------------------------------------------------

We will first use the commands dwiextract and mrmath to average together the B0 images from the diffusion data. These are 
the images that look most like T2-weighted functional scans, since a diffusion gradient wasn’t applied during their 
acquisition - in other words, they were acquired with a b-value of zero. To see how this works, navigate back to the dwi 
directory and type the following command:

.. code:: Bash

   dwiextract sub-02_den_preproc_unbiased.mif - -bzero | mrmath - mean mean_b0.mif -axis 3

The first step is to convert both the segmented anatomical image and the B0 images we just extracted:

.. code:: Bash

   mv ../anat/5tt_nocoreg.mif .
   mrconvert mean_b0.mif mean_b0.nii.gz
   mrconvert 5tt_nocoreg.mif 5tt_nocoreg.nii.gz

Since flirt can only work with a single 3D image (not 4D datasets), we will use fslroi to extract the first volume of the 
segmented dataset, which corresponds to the Grey Matter segmentation:

.. code:: Bash

   fslroi 5tt_nocoreg.nii.gz 5tt_vol0.nii.gz 0 1


We then use the flirt command to coregister the two datasets:

.. code:: Bash

   flirt -in mean_b0.nii.gz -ref 5tt_vol0.nii.gz -interp nearestneighbour -dof 6 -omat diff2struct_fsl.mat

.. code:: Bash

    mrtransform 5tt_nocoreg.mif -linear diff2struct_mrtrix.txt -inverse 5tt_coreg.mif

The resulting file, “5tt_coreg.mif”, can be loaded into mrview in order to examine the quality of the coregistration:

.. code:: Bash

   mrview sub-02_den_preproc_unbiased.mif -overlay.load 5tt_nocoreg.mif -overlay.colourmap 2 -overlay.load 5tt_coreg.mif -overlay.colourmap 1

The last step to create the “seed” boundary - the boundary separating the grey from the white matter, which we will use to 
create the seeds for our streamlines - is created with the command 5tt2gmwmi (which stands for “5 Tissue Type 
(segmentation) to Grey Matter / White Matter Interface)

.. code:: Bash

   5tt2gmwmi 5tt_coreg.mif gmwmSeed_coreg.mif

Again, we will check the result with mrview to make sure the interface is where we think it should be:

.. code:: Bash

   mrview sub-02_den_preproc_unbiased.mif -overlay.load gmwmSeed_coreg.mif

MRtrix Tutorial #7: Streamlines
-------------------------------

How Many Streamlines?
---------------------

The “correct” number of streamlines to use is still being debated, but at least 10 million or so should be a good starting 
place:

.. code:: Bash

   tckgen -act 5tt_coreg.mif -backtrack -seed_gmwmi gmwmSeed_coreg.mif -nthreads 8 -maxlength 250 -cutoff 0.06 -select 10000000 wmfod_norm.mif tracks_10M.tck


If you want to visualize the output, I recommend extracting a subset of the output by using tckedit:

.. code:: Bash

   tckedit tracks_10M.tck -number 200k smallerTracks_200k.tck

This can then be loaded into mrview by using the “-tractography.load” option, which will automatically overlay the 
smallerTracks_200k.tck file onto the preprocessed diffusion-weighted image:

.. code:: Bash

   mrview sub-02_den_preproc_unbiased.mif -tractography.load smallerTracks_200k.tck

Refining the Streamlines with tcksift2
--------------------------------------

To counter-balance this overfitting, the command tcksift2 will create a text file containing weights for each voxel in the 
brain:

.. code:: Bash

   tcksift2 -act 5tt_coreg.mif -out_mu sift_mu.txt -out_coeffs sift_coeffs.txt -nthreads 8 tracks_10M.tck wmfod_norm.mif sift_1M.txt

MRtrix Tutorial #8: Creating and Viewing the Connectome
-------------------------------------------------------

You can use any atlas you want, but for this tutorial we will be using the atlases that come with FreeSurfer. Accordingly, 
our first step will be to run the subject’s anatomical image through recon-all, which you can read more about here:

.. code:: Bash

   recon-all -i ../anat/sub-CON02_ses-preop_T1w.nii.gz -s sub-CON02_recon -all

This will take a few hours, depending on the speed of your computer. When it has finished, make sure to check the output by 
using the QA procedures described in this chapter.



Creating the Connectome












