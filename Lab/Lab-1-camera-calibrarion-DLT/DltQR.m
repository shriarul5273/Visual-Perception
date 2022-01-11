function [P,K,R,T] = DltQR(image,world_coordinates)
%% DltQR to perform the extraction of camera Parameter 
        %form the image coordinates with its corrosponding world coordinates

%   Input
%       image - Image coordinates of the corrosponding world points
%       world_coordinates - World coordiantes 
%
%   Output
%       P - Projection matrix
%       K - intrinsic Parameters
%       R - Rotation matrix
%       T - camera 3D pose
%% Function starts here
    % Scale correction on the image.
    imag2D_X = image(1,:)./ image(3,:);
    imag2D_Y = image(2,:)./image(3,:);
    % intlize an empty varibale to store the equations to solve
    L = [];
    % looping over all the points
    for i = 1:size(image,2)
%       alphax 
        alphax = [-world_coordinates(i,:),0,0,0,0,imag2D_X(1,i)*world_coordinates(i,:)];
        L = vertcat(L,alphax);
%       alphay 
        alphay = [0,0,0,0,-world_coordinates(i,:),imag2D_Y(1,i)*world_coordinates(i,:)];
        L = vertcat(L,alphay);
    end
    %solving the 2n x 12 matrix to get the Projection matrix
    [~,~,V] = svd(L);
    % extracting the last columns with the least eigenvalue
    J = V(:,end);
    A = J(1:4)';
    B = J(5:8)';
    C = J(9:12)';
    %forming the Projection matrix
    P = [A;B;C];
    
    %extracting the 3D pose of the camera
    h = P(:,4);
    H = P(:,1:3);
    T = -inv(H)*h ;

    %extracting the Rotation and intrinsic matrix
    [Q,K] = qr(inv(H));
    K = inv (K)*[-1 0 0;0 1 0;0 0 -1]; 
    K = K./(K(3,3))
    R = [-1 0 0;0 1 0;0 0 -1]*Q'
end