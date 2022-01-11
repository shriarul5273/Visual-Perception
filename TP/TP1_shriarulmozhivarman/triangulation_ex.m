clc
clear all

%%%%%%%
%In this matlab code file I have implemented the triangulation 
%alogrithm to extract 3D coordinates from image points(2 images)
% corrosponding to them.
%%%%%%
%% one 3D point

world_coordinate = [45 42 52 1]'; 
%% camera 1

K1 = [80 0 25;
    0 80 25;    %internsic parameter for camera 1
    0 0 1];
Cam1 = [eye(3) zeros(3,1)];
eul = [0 -pi/2 0];
R1 = eul2rotm(eul);  % rotation of camera 1
t1 = [0 0 0]'; % translation of camera 1

P1 = K1 * Cam1 * [R1 t1; zeros(1,3) 1];  % computing the projection matrix

%% camera 2

K2 = [5 0 25;
    0 5 25;  %internsic parameter for camera 2
    0 0 1];
R2 = eye(3);  % rotation of camera 2
t2 = [ 5 0 0]'; % translation of camera 1

P2 = K2 * Cam1 * [R2 t2; zeros(1,3) 1]; % computing the projection matrix
%% image 

m1 = P1*world_coordinate; %Image 2D projection from camera 1
m1 = m1./m1(3); 

m2 = P2*world_coordinate; %Image 2D projection from camera 2
m2 = m2./m2(3);

%formualating eqation of the form AX = 0 where X is the 3D points
sol = [[P1(3,:)*m1(1) - P1(1,:)];
     [P1(3,:)*m1(2) - P1(2,:)];
     [P2(3,:)*m2(1) - P2(1,:)];
     [P2(3,:)*m2(2) - P2(2,:)];
     ];

[~,~,V] = svd(sol);

M =  V(:,end);

% Extracted 3D world points
M = M./M(4)

%% Computing error with gaussian noise for one image point
errorM = [];
for i = 1:10
        gaussian = fspecial('gaussian',size(m1),0.08*i);
        noiseM1 = m1+gaussian;
        noiseM2 = m2+gaussian;
        sol = [[P1(3,:)*noiseM1(1) - P1(1,:)];
               [P1(3,:)*noiseM1(2) - P1(2,:)];
               [P2(3,:)*noiseM2(1) - P2(1,:)];
               [P2(3,:)*noiseM2(2) - P2(2,:)];];
        [~,~,V] = svd(sol);
        noiseM =  V(:,end);
        noiseM = noiseM./noiseM(4);
    errorM = [errorM sum(abs(M-noiseM))];
end
%ploting the error 
figure
plot(0.07*1:i,errorM)
title('Error vs Noise')
xlabel('Noise level(std)')
ylabel('error')

%% triangulation with 2 images

% The function make_3Dworld create a 3D world 
world_coordinate_full = make_3Dworld(50,50,50)';
                     
                  
% Projecting the image1
image1=P1*world_coordinate_full;
image1_homo = image1./image1(3,:);

% Projecting the image2
image2=P2*world_coordinate_full;
image2_homo  = image2./image2(3,:);

% variable for storing the predicted coordinates
world_coordinate_predict = [];
%formualating eqation of the form AX = 0 where X is the 3D points
for i = 1:size(image1,2)
    sol = [[P1(3,:)*image1_homo(1,i) - P1(1,:)];
            [P1(3,:)*image1_homo(2,i) - P1(2,:)];
            [P2(3,:)*image2_homo(1,i) - P2(1,:)];
            [P2(3,:)*image2_homo(2,i) - P2(2,:)]];
 [~,~,V] = svd(sol);
    M =  V(:,end);
    M = M./M(4);
    world_coordinate_predict = [world_coordinate_predict M];    
end


world_coordinate_predict
%% computing the error for the first 25 3D world coordinates
figure
for k = 1:25
    m1 = image1(:,k);
    m2 = image2(:,k);
    errorM = [];
    for i = 1:10
            gaussian = fspecial('gaussian',size(m1),0.07*i);
            noiseM1 = m1+gaussian;
            noiseM1 = noiseM1./noiseM1(3);
            noiseM2 = m2+gaussian;
            noiseM2 = noiseM2./noiseM2(3);
            sol = [[P1(3,:)*noiseM1(1) - P1(1,:)];
                   [P1(3,:)*noiseM1(2) - P1(2,:)];
                   [P2(3,:)*noiseM2(1) - P2(1,:)];
                   [P2(3,:)*noiseM2(2) - P2(2,:)];];
            [~,~,V] = svd(sol);
            noiseM =  V(:,end);
            noiseM = noiseM./noiseM(4);
        errorM = [errorM sum(abs(M-noiseM))];
    end
    plot(0.07*1:i,errorM)
    hold on
end
title('Error vs Noise')
xlabel('Noise level(std)')
ylabel('error')


