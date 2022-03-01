# process2x4Multispectral
Use MATLAB to process and colormap .tif files produced by 2ndLook using an 8-band NIR Multispectral Camera


This is a relatively simple script created to process and colormap multispectral .tif images.

For our case, our input images consist of a 2x4 grid of 256x256 pixel images. Together, the entire base image is 512x1024 pixels.

#Input Image:
![Screenshot 2022-03-01 115332](https://user-images.githubusercontent.com/44561221/156222324-a5c15396-4f46-4e11-8902-f4253dee71a2.png)


Using simple math, we can find the dimensions of each individual quadrant. By seperating each individual quadrant into their own image and stacking them into a single .tif file,
we can easily use the viewslices() command, then successfully colormap the slices.

#Output Image:
![Screenshot 2022-03-01 115212](https://user-images.githubusercontent.com/44561221/156222121-2ddaa874-7dd6-4eaa-8658-f0d4d7b08a40.png)
