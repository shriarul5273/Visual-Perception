%% Part - 0 Instructions for running the lab

% Part - 1 contains the code to load the data from lab0
% Part - 2 contains the code to simulate the 3D world Data
% Part - 3 contains the code to perform DLT by linear equation
%          and QR Decmposition
%        over the image created and world coordinates 
% Part - 4 contains the code to perform  DLT by Kronecker product 
%          and Cholesky factorization 
%        over the image created and world coordinates 

%%%%%%%%  Run  %%%%%%%%
%     1. part - 1 and part - 3
%     2. part - 2 and part - 4
%     3. part - 1 and part - 4
%     4. part - 2 and part - 3

%% Part - 1 world points from lab 0
close all
clear 
%%%loading data for the lab

%world coordinates to image
world_coordinates = load('pts3D.txt');
%intrinsic parameter of the camera
intrinsic_param = load('K.txt');
%wordl coordinate of the camera
optical_center = load('C.txt');
%3D roataion of the camera
rotation_matrix = load('R.txt');
%trainslation from the origin
translation = -rotation_matrix*optical_center;

%exterinic parameter of the camera from the 3D rotation and translation
exterinic_param = [rotation_matrix translation];

% Projection matrix from the intrinsic and exterinic parameter
P = intrinsic_param * exterinic_param

% converting the world coordinates into the homogeneous coordinates
world_coordinates(:,4) = 1 ;

% creating the image from the projection matrix
image = (intrinsic_param*exterinic_param*transpose(world_coordinates));


%% Part - 2 custom world points 
clear 
close all
%%%loading data for the lab

%intrinsic parameter of the camera
intrinsic_param = load('K.txt');
%wordl coordinate of the camera
optical_center = load('C.txt');
%3D roataion of the camera
rotation_matrix = load('R.txt');
%trainslation from the origin
translation = -rotation_matrix*optical_center;

%exterinic parameter of the camera from the 3D rotation and translation
exterinic_param = [rotation_matrix translation];

% creating Homogeneous world coordinates 
world_coordinates = make_3Dworld(150,150,150);

% Projection matrix from the intrinsic and exterinic parameter
P = intrinsic_param * exterinic_param

% creating the image from the projection matrix
image = (intrinsic_param*exterinic_param*transpose(world_coordinates));
%% part - 3  DLT with the QR Decomposition

% solving to get the paramters of camera from 
% QR decomposition and DLT equation 
[P,K,R,T] = DltQR(image,world_coordinates)

%forming the image from the results of DLT
image = P * (world_coordinates');

% Scale correction on the image to plot
imag2D_X1 = image(1,:)./ image(3,:);
imag2D_Y1 = image(2,:)./image(3,:);

% ploting the image
figure
plot(imag2D_Y1,imag2D_X1,'*b')
title('Image fromed from DLT and QR  Decomposition')

% extracting intrinsic parameters
fx = K(1,1)
fy = K(2,2)
u  = K(1,3)
v  = K(2,3)

% extracting the euler angles from the rotation matrix
alpha = atan2d(R(2,1),R(1,1))
beta = atan2d(-R(3,1),sqrt(R(3,2)^2+R(3,3)^2))
gamma = atan2d(R(3,2),R(3,3))
%% Part - 4 DLT with Kronecker product and Cholesky factorization 

% solving to get the paramters of camera from 
% Cholesky factorization and DLT (Kronecker product)
[P,K,R,T] = DltChol(image,world_coordinates)

%forming the image from the results of DLT
image = P * (world_coordinates');

% Scale correction on the image to plot
imag2D_X2 = image(1,:)./ image(3,:);
imag2D_Y2 = image(2,:)./image(3,:);
% ploting the image
figure
plot(imag2D_Y2,imag2D_X2,'*r')
title('Image fromed from DLT and Cholesky factorization ')

% extracting intrinsic parameters
fx = K(1,1)
fy = K(2,2)
u  = K(1,3)
v  = K(2,3)

% extracting the euler angles from the rotation matrix
alpha = atan2d(R(2,1),R(1,1))
beta = atan2d(-R(3,1),sqrt(R(3,2)^2+R(3,3)^2))
gamma = atan2d(R(3,2),R(3,3))