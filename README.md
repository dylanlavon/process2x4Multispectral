# process2x4Multispectral
##### Use MATLAB to process and colormap .tif files produced by 2ndLook using an 8-band NIR Multispectral Camera



## Required Packages
The use of this script within MATLAB requires the following MATLAB Packages:

[Multipage TIFF Stack](https://www.mathworks.com/matlabcentral/fileexchange/35684-multipage-tiff-stack)

[Image Processing Toolbox](https://www.mathworks.com/products/image.html)

[Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html)

For our case, our input images consist of a 2x4 grid of 256x256 pixel images. Together, the entire base image is 512x1024 pixels. This 512x1024 base image can have any number of 1, 2, 4, or 8 bands. 

This repo includes two scripts: processSingleImage.m and processAllDirectories.m

## processSingleImage.m - For processing and viewing a single image stack.
Users can specify the amount of bands using the configuration variables at the top of the script. It is important to correctly identify the source image. After running the script, the base image will be proccessed and saved, then subsequently displayed using MATLAB's sliceviewer.

## processAllDirectories.m - For processing all available source images in base directories.
This script makes it easier to process large amounts of data at once. The script will pull all images from the 1, 2, 4, and 8 folders from the 'baseImages' directory, slice and map them, then save them to the 'processedImages' directory. 

*Note: If a file already exists with the attempted name during the writing process, an integer will be appended and iterated to prevent overwriting. This applies to both scripts.*


## processSingleImage Configuration Variables
![ProcessSingleImage config screenshot](https://user-images.githubusercontent.com/44561221/158435428-b5ed764b-9755-4b3b-b045-43bb95bce329.png)

**baseImgName** - Must match the target base image's name. Do NOT include the file extension. File must be of type .tif. This can be selected during export from 2ndLook.
Be sure to follow the naming convention of day_month_year_Project_Subject_numOfBands like so -> 01_03_22_Multispectral_face_8Band

**cMap** - Color map to use. A list of all colormaps can be seen [here:](https://www.mathworks.com/help/matlab/ref/colormap.html#:~:text=the%20predefined%20colormaps.-,Colormap%20Name,-Color%20Scale)

**addDesc** - Boolean value that determines whether or not description text will be added. Text is determined by descFontSize.

**descFontSize** - Font size for displayed description text.

## processSingleImage Configuration Variables
![ProcessAllDirectories config screenshot](https://user-images.githubusercontent.com/44561221/158436230-3ce3be98-34a4-41af-8f79-98a9cbe96980.png)

**cMap** - Color map to use. A list of all colormaps can be seen [here:](https://www.mathworks.com/help/matlab/ref/colormap.html#:~:text=the%20predefined%20colormaps.-,Colormap%20Name,-Color%20Scale)

## Directory Setup
As Github does not support empty directories and the image files are too large to upload, the empty directories are not included in the repo. Please ensure that your main project directory looks like the following.

![directory](https://user-images.githubusercontent.com/44561221/158438789-b6ecb21e-06a2-4f9c-86ba-adb577165dbf.png)

Be sure to put your images into their respective folders based on their amount of bands, as well as ensure the correct naming convention and file type for the scripts to operate properly.

## Example Input Images:

<img src="https://user-images.githubusercontent.com/44561221/156222324-a5c15396-4f46-4e11-8902-f4253dee71a2.png" alt="drawing" width="500"/>
<img src="https://user-images.githubusercontent.com/44561221/157518188-f7cb46f6-1cc6-4e79-9646-a67d84894337.png" alt="drawing" width="500"/>




## Example Output Stacks:

![8band gif](https://user-images.githubusercontent.com/44561221/157520577-6dc97300-b185-4280-b8a7-995c6608bb0b.gif)
![hand gif](https://user-images.githubusercontent.com/44561221/157517382-4d22ed2e-9402-4ff9-9315-3bf6e64c86e0.gif)


