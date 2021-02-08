clc
clear;

final_img = main();

%Main function:
function output = main()
    input_img = imread('testimage.jpg');
    rotate_image = rotate(input_img);   
    scaled_image = scale(rotate_image, 2);  
    grayWorld_image = grayWorld(scaled_image, 80);  
    white_ref = whiteRef(grayWorld_image);
    enhanced_image = enhancement(white_ref);
    output = denoise(enhanced_image);
    figure,subplot(121),imshow(input_img);title('Test Image');
    subplot(122),imshow(output);title('Final Result'); 
end

%Task1:
function output = rotate(input)
    rotate_img = imrotate(input, -5, 'bicubic', 'crop'); %Negative angle shows that the image is rotated in clockwise direction
    output = imcrop(rotate_img, [50,50,1200,880]);
    rotate_img2 = imrotate(input, -5, 'nearest', 'crop'); %Negative angle shows that the image is rotated in clockwise direction
    output2 = imcrop(rotate_img2, [50,50,1200,880]);
    rotate_img3 = imrotate(input, -5, 'bilinear', 'crop'); %Negative angle shows that the image is rotated in clockwise direction
    output3 = imcrop(rotate_img3, [50,50,1200,880]);
    figure
    subplot(221)
    imshow(input)
    title('Input Image')
    subplot(222)
    imshow(output2)
    title('Nearest Neighbor')
    subplot(223)
    imshow(output3)
    title('Bilinear')
    subplot(224)
    imshow(output)
    title('Bicubic')
    figure
    subplot(131)
    imshow(input)
    title('Input Image')
    subplot(132)
    imshow(rotate_img)
    title('Rotated Image')
    subplot(133)
    imshow(output)
    title('Bicubic Interpolation')
end

%Task2: 
function output = scale(input, factor)
    image = input;
    oldSize = size(image);
    newSize = max(round(factor.*oldSize(1:2)),1); %We apply max function to avoid values less than 1
    img2 = repmat(uint8(0), newSize(1), newSize(2));    %Matrix of new dimensions is created
    [x2, y2] = size(img2);
    RR = oldSize(1)/x2;
    RC = oldSize(2)/y2;
    r_pos = [1:x2];                                     
    c_pos = [1:y2];
    IR = ceil(r_pos.*(RR));                             %matrix of positions in a row to be mapped
    IC = ceil(c_pos.*(RC));                             %matrix of positions in a column to be mapped
    img3 = zeros([x2,y2,3]);
    for k = 1:3
        channel_img2 = image(:,:,k);
        for m = 1:size(IR,2)                            %Loop runs over the new matrix ie. img2 and at each pixel 
            for j = 1:size(IC,2)                        %it maps the value from the original matrix ie. image
                img2(m,j) = channel_img2(IR(m),IC(j));  %to img2 as per the index/position at that pixel. 
            end
        end
        img3(:,:,k)=img2;
    end
    output = uint8(img3);
    figure,subplot(121),imshow(input);title('Input Image'); axis([0,5000,0,5000]);axis on;
    subplot(122),imshow(output);title('Scaled Image'); axis([0,5000,0,5000]);axis on;
end

%Task3:
function output = grayWorld(input, scal)
    input = im2uint8(input);
    dim = size(input,3);
    output=zeros(size(input));    
    for i=1:dim
        channel_img = input(:,:,i);
        scal_img = sum(sum(channel_img))/numel(channel_img);    %Average is calculated of each channel
        scal_channel = scal/scal_img;                           %scaling factor 
        output(:,:,i) = (scal_channel)*(channel_img);            
        disp(mean(output(:,:,i), 'all'))
    end
    output=uint8(output);    
    figure
    subplot(121)
    imshow(input)
    title('Input Image')
    subplot(122)
    imshow(output)
    title('Gray World Algorithm Result')
end

%Task 4:
function output = whiteRef(input)
    paper_img = imread('whitepaper.jpg');
    crop_img = imcrop(paper_img,[300 200 600 550]);
    red_max = max(crop_img(:,:,1), [], 'all');
    green_max = max(crop_img(:,:,2), [], 'all');
    blue_max = max(crop_img(:,:,3), [], 'all');
    o_red = max(input(:,:,1), [], 'all');
    o_green = max(input(:,:,2), [], 'all');
    o_blue = max(input(:,:,3), [], 'all');
    alpha = o_red/red_max;                          %To calculate a scaling factor we'd divide the maximum intensity of the original image's channel
    beta = o_green/green_max;                       %with the respective channel of the whitepaper image
    gamma = o_blue/blue_max;
    output(:,:,1) = input(:,:,1)*alpha;             %We multiply the resulting factor with the original image for white balancing  
    output(:,:,2) = input(:,:,2)*beta;
    output(:,:,3) = input(:,:,3)*gamma;
    figure
    subplot(121)
    imshow(input)
    title('Input Image')
    subplot(122)
    imshow(output)
    title('White Referenced Image')
end

%Task 5:
function [output] = enhancement(input)
    img = input;
    %Method 1:
    figure
    subplot(131)
    plot(imhist(img(:,:,1)))
    title('Red-channel Histogram')
    subplot(132)
    plot(imhist(img(:,:,2)))
    title('Green-channel Histogram')
    subplot(133)
    plot(imhist(img(:,:,3)))
    title('Blue-channel Histogram')
    output = zeros(size(img));                                  %With imadjust old range of intensity is mapped on new range of intensities values
    output(:,:,1) = imadjust(img(:,:,1), [0.1;0.9], [0;1]);
    output(:,:,2) = imadjust(img(:,:,2), [0.1;0.9], [0;1]);
    output(:,:,3) = imadjust(img(:,:,3), [0.1;0.9], [0;1]);
    output2 = uint8(output);
    %Method 2:
    hsv_img = rgb2hsv(img);
    s_hsv = hsv_img(:,:,2).*255;
    pdf = imhist(s_hsv)/numel(s_hsv);
    cdf = cumsum(pdf);                                %Transformation function
    ihigh = find(cdf >= 0.9, 1, 'first');
    scale_fac = 255/ihigh;
    scale_img = hsv_img.*scale_fac;
    double_img = im2double(scale_img);
    output = hsv2rgb(double_img);
    figure
    subplot(121)
    imshow(output2)
    title('Method 1: Using Imadjust')
    subplot(122)
    imshow(output)
    title('Method 2: Automated Method')
end

%Task 6:
function [output] = denoise(input)
    img = input;
    fil = fspecial('gaussian'); %I tried 'gaussian', 'laplacian', 'log', 'sobel', 'average' but I found 'gaussian' to work best for the testimage
    output = imfilter(img, fil, 'conv');
    figure
    subplot(121)
    imshow(img)
    title('Original Image')
    subplot(122)
    imshow(output)
    title('Denoised Image with Gaussian')
end