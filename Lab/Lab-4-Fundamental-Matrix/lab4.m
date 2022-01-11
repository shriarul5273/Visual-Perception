
clc
clear all

%loading the image points
imageP1 = load('pts2D_1.txt');
imageP2 = load('pts2D_2.txt');


% converting image coordincates to homogenoues form
imageP1(:,3) = 1;
imageP2(:,3) = 1;

%computing the FundamantalMatrix 
F_matrix = ComputeFundamentalMatrix(imageP1,imageP2);

%computing the error
error = [];
for i = 1:300
    Z = imageP1(i,:)*F_matrix*imageP2(i,:)';
    error = [error;Z];
end
% summing all the error
Error = sum(abs(error));

%selecting random points
i = randi(300);
j = randi(300);

%ploting the epipolar line and the image point
polar_line1 = F_matrix*imageP2(i,:)';
polar_line1(:,:) = polar_line1(:,:)./-polar_line1(2,:);
f = @(x) polar_line1(1,:)*x+polar_line1(3,:);
ezplot( f, 100, 400)
hold on
plot(imageP1(i,1),imageP1(i,2),'g*')
title('Epipolar lines on the image point')

% computing the epipoles
polar_line1 = F_matrix*imageP1(i,:)';
polar_line2 = F_matrix*imageP1(j,:)';

epipoles = cross(polar_line1',polar_line2')

polar_line1 = F_matrix*imageP2(i,:)';
polar_line2 = F_matrix*imageP2(j,:)';

epipoles = cross(polar_line1',polar_line2')

%%
clear all
close all


errors = [];
for i = 1:10
%loading the image points

    imageP1 = load('pts2D_1.txt');
    imageP2 = load('pts2D_2.txt');

    % converting image coordincates to homogenoues form
    imageP1(:,3) = 1;
    imageP2(:,3) = 1;
%   Generating the Gaussian error and adding it to the image
    gaussian = fspecial('gaussian',size(imageP1),0.5*i);
    imageP1 = imageP1+gaussian;
    imageP2 = imageP2+gaussian;


    imageP1 = imageP1./imageP1(:,3);
    imageP2= imageP2./imageP2(:,3);

%computing the FundamantalMatrix on the noised images

    F_matrix = ComputeFundamentalMatrix(imageP1,imageP2);
% calculating the error
    error = [];
    for i = 1:300
        Z = imageP1(i,:)*F_matrix*imageP2(i,:)';
        error = [error;Z];
    end
    sumError = sum(abs(error));
    errors = [errors;sumError];
end
%ploting the error vs std
plot(1:10,errors,'-r')
grid on
title('Error vs Std on Gaussian')
xlabel('Std on the Gaussian')
ylabel('error')