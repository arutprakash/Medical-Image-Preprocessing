close all; close all
clc

srcFile= dir('/MATLAB Drive/Medical Imagings/CT - Head and Neck/HN-CHUM-001/*.dcm')

%% getting the files saved in parameters
for i=1:length(srcFile)
    filename= strcat('/MATLAB Drive/Medical Imagings/CT - Head and Neck/HN-CHUM-001/',srcFile(i).name)
    I = dicomread(filename)
    info= dicominfo(filename)
    
    %structural element to apply filter
    se = strel('line',1,1);
    %%
    % _ITALIC TEXT_ 
    
    %erosion
    %erodedI = imerode(I,se);
    
    %thresholding
    image_threshold = I;
    image_threshold(I<100) = 255;
    image_threshold(I>100) = 0;
    
    %dilation
    se = strel('disk',1);
    dilatedI = imdilate(image_threshold,se);
    
    %edge detection
    b = edge(dilatedI)
    
    %dilation
    se = strel('disk',1);
    dilatedI2 = imdilate(b,se);
    
    %display result
    figure()
    
    subplot(1,4,1)
    imshow(I,[])
    title('original image')
    
    subplot(1,4,2)
    imshow(dilatedI,[])
    title('dilated image')
    
    subplot(1,4,3)
    imshow(image_threshold,[])
    title('thresholded image')
    
    subplot(1,4,4)
    imshow(dilatedI2,[])
    title('edge detection')
    
    
    %dicomwrite(dilatedI2,filename,info)
   
    
    
end