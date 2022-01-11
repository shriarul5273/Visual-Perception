clc
clear all
close all

%%%loading data for the lab
%intrinsic parameter of the camera
intrinsic_param = load('K.txt');
%wordl coordinate of the camera
optical_center = load('C.txt');
%3D roataion of the camera
rotation_matrix = load('R.txt');
%creating the 3D world for simulation
world_coordinates = make_3Dworld(150,150,150);

%trainslation from the origin
translation = -rotation_matrix*optical_center;

%exterinic parameter of the camera from the 3D rotation and translation
exterinic_param = [rotation_matrix translation];

% Projection matrix from the intrinsic and exterinic parameter
P = intrinsic_param * exterinic_param;

%ploting the world coordinates with plot3d
plot3(world_coordinates(:,1),world_coordinates(:,2),world_coordinates(:,3),".")
hold on
grid on
title('3D world and the camera')

%plot the camera to visulize the in the 3d World 
absPose = rigid3d(rotation_matrix,optical_center');
plotCamera('AbsolutePose',absPose,'Size',50)

actualImage = (intrinsic_param*exterinic_param*transpose(world_coordinates));
%%
% scaled image coordinates  
imag2D_X = actualImage(1,:)./ actualImage(3,:);
imag2D_Y = actualImage(2,:)./actualImage(3,:);

errors_cum = zeros(10,1);

for i = 1:15

    %creating the gaussian noise
    gaussian = normrnd(0,0.75,size(actualImage));
    %noise image
    noisedImage = actualImage+gaussian;

    imag2D_X1 = noisedImage(1,:)./noisedImage(3,:);
    imag2D_Y1 = noisedImage(2,:)./noisedImage(3,:);

    %ploting the image and comparing the actual and noised
    figure
    plot(imag2D_Y,imag2D_X,'b*')
    hold on
    plot(imag2D_Y1,imag2D_X1,'r*')
    title('Comparing Actual Image and Noised Image')
    legend('Actual Image','Noised Image')
    
    
    %sloving to get the parametes from actual image with the Cholesky decomposition
    [AcP,AcK,AcR,AcT] = DltChol(actualImage,world_coordinates);
    
    %sloving to get the parametes from Noised image with the Cholesky decomposition
    [NoP,NoK,NoR,NoT] = DltChol(noisedImage,world_coordinates);



    % extracting intrinsic parameters
    actualfx = AcK(1,1);
    actualfy = AcK(2,2);
    actualu  = AcK(1,3);
    actualv  = AcK(2,3);

    % extracting the euler angles from the rotation matrix
    actualalpha = atan2d(AcR(2,1),AcR(1,1));
    actualbeta = atan2d(-AcR(3,1),sqrt(AcR(3,2)^2+AcR(3,3)^2));
    actualgamma = atan2d(AcR(3,2),AcR(3,3));



    % extracting intrinsic parameters
    noisefx = NoK(1,1);
    noisefy = NoK(2,2);
    noiseu  = NoK(1,3);
    noisev  = NoK(2,3);

    % extracting the euler angles from the rotation matrix
    noisealpha = atan2d(NoR(2,1),NoR(1,1));
    noisebeta = atan2d(-NoR(3,1),sqrt(NoR(3,2)^2+NoR(3,3)^2));
    noisegamma = atan2d(NoR(3,2),NoR(3,3));

    errors = [actualfx - noisefx;
             actualfy - noisefy;
             actualu  - noiseu;
             actualv  - noisev;
             AcT      - NoT;
             actualalpha - noisealpha;
             actualbeta - noisebeta;
             actualgamma - noisegamma ];
         
     errors_cum = errors_cum+errors;
end
disp('average error after 15 iterations')
% calculating the mean error
errors_cum/15