# Automatic-pill-counter
An application to count number of pills in a Image
 

Prerequisites:
 Install python(preferably 3.8 or 3.9), required packages, and cocoa pods.
 
 
Code Explanation ( the final code that was implemented for pill counter i.e with watershed
algorithm): 

Initially, we load the image from google drive(So in order to test the code we are providing
images in the zip folder) and check if the size of the image is less than 200X200. If the image
size is less than that it calls the superresolution() function and returns the enlarged image. We
have used pre-trained EDSR opencv model for super resolution . In order to load the model in
super resolution function we are providing the EDSR model(EDSR_x4.pb) in the Zip folder, so
add path which leads to EDSR model.

The next step is applying pyramid mean shift filtering. Mean shift filtering is done to smoothen
the image so that it makes the thresholding accurate.

It is important to know the background color of the image before applying the threshold. The
threshold we apply is different according to the background color. To check the background
color, we have considered 2 corner edges of the image with minimum dimensions. We have used
the mostCommon() function to check the most occured RGB values in that area. The function
returns the most occured RGB values the borders.The most common pixel returned by the
mostCommon() function is used to decide between threshold methods. If any of the values in the
pixel array is less than 128 then Thresh_Binary_INV is used else Thresh_Binary is used along
with the Thresh_OTSU.

First the image is converted to gray from bgr using cv2.cvtcolor(). If the pills we need to count
are in lighter colors and the background is dark then we apply cv2.THRESH_BINARY_INV or
cv2.THRESH_OTSU threshold method so that it highlights the area where the pills are in white
and rest will be covered in black color. Similarly, if the pills are in a darker color and the
background is lighter then we apply cv2.THRESH_BINARY or cv2.THRESH_OTSU threshold
method. As we have a threshold image, We can apply the watershed algorithm now.
