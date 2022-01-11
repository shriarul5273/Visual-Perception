clc;clear all
close all

%%%Matlab implementation for Harris corner detector.
tic;

%loading the image
image_rgb = imread('checker.png');

% convert the image to gray scale
%comment this line if gray scale image is used
image = rgb2gray(image_rgb);

%uncomment the below line if the image is grayscale
% image = image_rgb;

%display the image
figure;imshow(image);

%diravative
diravative = [-1 0 1;-1 0 1;-1 0 1];

% convulating to get the Ix,Iy
Ix = conv2(image,diravative,'same');
Iy = conv2(image,diravative','same');

%display the diravative images
figure;imshow(Ix);title('derivative in X');
figure;imshow(Iy);title('derivative in Y');


%defining the window size and window function
windowSize = 5;
windowFunction = fspecial('gaussian');


% convulating to get the Ix2,Iy2,Ixy
Ix2 = conv2(Ix.^2, windowFunction);
Iy2 = conv2(Iy.^2, windowFunction);
Ixy = conv2(Ix.*Iy, windowFunction);

% set empirical constant between 0.04-0.06
k = 0.05;


% create a matrix to hold the Harris values
Hcorners = zeros(size(image));
image_size = size(image);
h = image_size(1);
w = image_size(2);

%geting the matrix corner value for each pixel
%loopin it over the image to get cornerness
for  i = (windowSize+1):(h-windowSize)
    for j = (windowSize+1):(w-windowSize)
        
        kernelIx = Ix2(i-windowSize:i+windowSize,j-windowSize:j+windowSize);
        kernelIy = Iy2(i-windowSize:i+windowSize,j-windowSize:j+windowSize);
        
        A = zeros(2,2);
        % creating the matrix structure tensor for the kernel
        A(1,1) = sum(kernelIx(:).^2,'all');
        A(1,2) = sum(kernelIx(:).*kernelIy(:),'all');
        A(2,1) = sum(kernelIx(:).*kernelIy(:),'all');
        A(2,2) = sum(kernelIy(:).^2,'all');
        

        R = det(A) - (k * trace(A)^2);
        
        Hcorners(i,j) = R;
       
    end
end

%displaying the heatmap
g = 255*mat2gray(Hcorners);
figure;imshow(g);

%thresholding the image the to get the corners

threshold = abs(10* mean(Hcorners,'all'));

%extracting the inedx of possible corners
[row, col] = find(Hcorners > threshold);

length = size(row);


%setting the corner index pixel values to max 
for i =1:length(1)
    image_rgb(row(i),col(i),1) = [255];
end

%visualise the corner
figure;imshow(image_rgb);


%comparing the images with inbuilt function
corners = detectHarrisFeatures(image);
imshow(image);hold on;
plot(corners.selectStrongest(50));

%timming the alogrithm to get performance of the implementation
toc;

