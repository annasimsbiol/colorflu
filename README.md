# colorflu
Code used to process images from the Celigo microscope in ImageJ
Contains 3 macros which must be used in order to generate images
LUT assignment - generates black and white and green/magenta images
Presentation macro - merges the correct green/magenta channels together
Montage creator - forms a 9 image montage

INPUT
Images must contain two channels - green and red (assigned ch1 or ch2)
At 3 time points denoted 24, 48 or 72
Must be in tif format to start

OUTPUT
Individual channel images with the background removed and black and white
False color images with LUT applied
Merged images with colors
A 9 image montage of black and white seperate channel and false color merged images

Contains another 2 macros used to calculate the % of coinfected area of plaques
Thresholding macro - applied a blanket threshold
Calculating white area - outputs the area of white ("and" function) and the total area of the plaque ("or" function)

INPUT
Images must contain two channels - green and red (assigned ch1 or ch2)
At 3 time points denoted 24, 48 or 72
Must be in tif format to start

OUTPUT
Threshold applied images
A text file containing the two numbers (copy and paste into excel for analysis)
