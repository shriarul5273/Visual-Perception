clc;clear all
close all

tic;
image_rgb = imread('cameraman.tif');
% image = rgb2gray(image_rgb);
image = image_rgb;
figure;imshow(image);

diravative = [-1 0 1;-1 0 1;-1 0 1];


Ix = conv2(image,diravative,'same');
Iy = conv2(image,diravative','same');
figure;imshow(Ix);title('derivative in X');
figure;imshow(Iy);title('derivative in Y');
windowSize = 5;
windowFunction = fspecial('gaussian');



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

% % get our matrix corner value for each pixel
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


g = 255*mat2gray(Hcorners);
figure;imshow(g);

threshold = abs(10* mean(Hcorners,'all'));
[row, col] = find(Hcorners > threshold);

length = size(row);

for i =1:length(1)
    image_rgb(row(i),col(i),1) = [255];
end
figure;imshow(image_rgb);



corners = detectHarrisFeatures(image);
imshow(image);hold on;
plot(corners.selectStrongest(50));



toc;

