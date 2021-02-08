# Digital-Photo-Enhancement-Restoration

## Task 1: 
Rotate the image with a suitable angle to correct the tilt of the image. You can use the functions included with the Image Processing Toolbox, e.g. imrotate. Test different interpolation methods and compare the results, and you may also want to crop the resulting image.

## Task 2:
Design a MATLAB function that can resample/scale the original image by an arbitrary factor (including decimal values such as 2.7), using nearest neighbor interpolation. The usage of MATLAB provided functions for resampling or interpolation is prohibited (e.g. functions imresize, resample, upsample, downsample and interp2). For example, if the scaling factor is 2, the output consists of twice as many pixels in x and y directions as the original one. Hint: Generate a new matrix of the required size, and go through this new matrix pixel by pixel and copy the correct values from the original image to this new matrix. Set the scale to 0.5, and scale the image down with the implemented algorithm.

## Task 3:
Write MATLAB code that corrects the white balance by applying the gray world technique. You must scale the values of R, G, and B channels in such a way, that mean intensities of red, green, and blue channels become equal. Take care that no data saturates during the correction process (for example, all variables of type uint8 must not exceed the value 255). In professional photography where correct tone of colors is crucial, the white balance correction is often performed by calibrating the gray world technique with a white reference target imaged in the same environment as the photo itself. The use of white reference assures that the calibration will be correct since the target is a priori known to be gray (or white in this case). In practice, the photographer has a piece of white paper in his pocket, and before taking the actual photos, the white paper is imaged. This image is then used in calculating the normalization coefficients for R, G, and B channels.

## Task 4: 
Download the photo of white paper crop the image to remove everything but the white paper, and calibrate the implemented gray world scaling with that image. Then apply the correction to the example image (not to the white paper). In other words, in Task 3 you calculated some correction coefficients that you used in scaling the color channels. Now you have to calculate these coefficients from the white paper, but apply the scaling to the original image of the forest.

## Task 5:
See the histograms of each of the color channels of the image, and apply suitable contrast enhancement with imadjust. Give separate values for each of the three color channels for all input parameters low_in, high_in, low_out and high_out. This phase also gives the possibility for final adjustment of thewhite balance, since the transfer function curves can be different for each of the R, G and B channels. For reference, also correct the contrast by a simple automated method: First transfer the image from RGB color space to a space where the intensity (value) component is separate from the color information. Then stretch the values of the intensity components such that 1% of the data saturates. For example, uint8 image intensities must be scaled between 0-255 in such a way that 1% of the pixels with highest intensity values become larger than 255 (and thereafter saturate to 255). Don’t change the color information matrices. After the scaling, transform the result back to RGB and compare the result with the manually adjusted image. If the result does not look adequate, try other saturation percentage values.

## Task 6: 
Filter the noise with convolution based filters using imfilter function (fspecial can also be useful). Test several different filters and parameters and select the one you find best. Also try to select the coefficients for the filter kernel h manually. Finally crop the image to remove the extra black areas from the image and you are done. After you have carefully tested all the implemented functions, you can try the functions with the original image, without using the scaling of Task 2. Depending on the implementation of your functions, the processing can take anything from a few seconds to up to an hour. The higher resolution helps especially the noise removal, since blur emerging from the filter is diminished.

## Result:
![snip2](https://user-images.githubusercontent.com/65900166/107266562-84602000-6a67-11eb-9f3e-2e372edbed4e.png)

## Note:
Check out report uploaded for intermediate results and analyses. 
