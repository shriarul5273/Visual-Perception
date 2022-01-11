clc
clear all 
close all
%%
%%% AIM of this lab is to simulate pinhole camera and perspective
%%% projection

%%%loading all the data from the given data%%%

%world points in 3D coordinates 
world_coordinates = load('pts3D.txt');
%intrinci parametes 
intrinsic_param = load('K.txt');
%translation of the camera 
optical_center = load('C.txt');
% rotation of the camera 
rotation_matrix = load('R.txt');

 
translation = -rotation_matrix*optical_center;

exterinic_param = [rotation_matrix translation];

world_coordinates(:,4) = 1 ; 


imag = (intrinsic_param*exterinic_param*transpose(world_coordinates));

imag2D_X = imag(1,:)./ imag(3,:);
imag2D_Y = imag(2,:)./imag(3,:);


plot3(world_coordinates(:,1),world_coordinates(:,2),world_coordinates(:,3),".")
hold on
% figure

%%
absPose = rigid3d(rotation_matrix,optical_center');
plotCamera('AbsolutePose',absPose,'Size',150)
figure
plot(imag2D_Y,imag2D_X,'*r')
