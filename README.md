# process2x4Multispectral
##### Use MATLAB to process and colormap .tif files produced by 2ndLook using an 8-band NIR Multispectral Camera



## Required Packages
The use of this script within MATLAB requires the following MATLAB Packages:

[Multipage TIFF Stack](https://www.mathworks.com/matlabcentral/fileexchange/35684-multipage-tiff-stack)

[Image Processing Toolbox](https://www.mathworks.com/products/image.html)

[Computer Vision Toolbox](https://www.mathworks.com/products/computer-vision.html)


For our case, our input images consist of a 2x4 grid of 256x256 pixel images. Together, the entire base image is 512x1024 pixels. This 512x1024 base image can have any number of 2, 4, 6, or 8 bands. Users can specify the amount of bands using the configuration variables at the top of the script.


## Configuration Variables
![variables](https://user-images.githubusercontent.com/44561221/157510434-70ff455c-17c5-48fe-bc11-e32c19eaca5e.png)

**baseImageDirectory** - Path to folder that holds the base images output from 2ndLook.

**processedImageDirectory** - Path to folder that receives processed images.

**baseImgName** - Must match the target base image's name. Do NOT include the file extension. File must be of type .tif. This can be selected during export from 2ndLook0.


_Note that the following two variables must currently be manually adjusted when changing number of input bands._

**baseImgHeight** - Base image height in pixels.

**baseImgWidth** - Base image width in pixels.


**addDesc** - Boolean value that determines whether or not description text will be added. Text is determined by descFontSize and the 'bands' array.

**descFontSize** - Font size for displayed description text.

**cMap** - Color map to use. A list of all colormaps can be seen [here:](https://www.mathworks.com/help/matlab/ref/colormap.html#:~:text=the%20predefined%20colormaps.-,Colormap%20Name,-Color%20Scale)

**bands** - Array that holds every possible band that can be output from the current camera.


## Example Input Images:

<img src="https://user-images.githubusercontent.com/44561221/156222324-a5c15396-4f46-4e11-8902-f4253dee71a2.png" alt="drawing" width="500"/>
<img src="https://user-images.githubusercontent.com/44561221/157518188-f7cb46f6-1cc6-4e79-9646-a67d84894337.png" alt="drawing" width="500"/>




## Example Output Stacks:

![8band gif](https://user-images.githubusercontent.com/44561221/157520577-6dc97300-b185-4280-b8a7-995c6608bb0b.gif)
![hand gif](https://user-images.githubusercontent.com/44561221/157517382-4d22ed2e-9402-4ff9-9315-3bf6e64c86e0.gif)


