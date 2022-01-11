function [P,K,R,T] = DltChol(image,world_coordinates)
%% DltChol to perform the extraction of camera Parameter 
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
    % intlize an empty varibale to store the equations to solve
    L = [];
    for i = 1:size(image,2)
        % image coordinates in the form to perform the cross product
        mi = [0 -image(3,i) image(2,i);image(3,i) 0 -image(1,i);-image(2,i) image(1,i) 0 ];
        % world point of the corrosponding image 
        Mi = world_coordinates(i,:);
        % performing the Kronecker Tensor Product
        K = kron(Mi,mi);
        L = vertcat(L,K);
    end
    %solving the 2n x 12 matrix to get the Projection matrix
    [~,~,V] = svd(L);
    % extracting the last columns with the least eigenvalue
    J = V(:,end);
    % reshape the last column to get the projection matrix
    P = reshape(J,[3,4]);
    h = P(:,4);
    H = P(:,1:3);
 
    %extracting the 3D pose of the camera
    T = -inv(H)*h;
    
    %extracting the Rotation and intrinsic matrix
    K = inv(chol(inv(H*H')));
    R = inv(K)*H;
    K = K./(K(3,3));
end