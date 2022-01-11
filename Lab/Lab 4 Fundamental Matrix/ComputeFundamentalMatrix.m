function F_matrix = ComputeFundamentalMatrix(imageP1,imageP2)
%% ComputeFundamentalMatrix 
        %form the image coordinates with its corrosponding image poins in 
%         the second image compute the fundamental matrix 
%   Input
%       imageP1 - Image coordinate points of a image in homogeoeous form
%       imageP2 - corrosponding image poin in the streo in homogeoeous form
%
%   Output
%       F_matrix - Fundamental Matrix of the streo images
%% Function starts here

% Preprocessing
% the centroid of the transformed points is at the origin and
% the average distance of the transformed points to the origin is sqrt(2)
% from the Hartley, Richard I. "In defense of the eight-point algorithm." 


% processing on the imageP1
    mean_p1 = mean(imageP1);
    Centred_p1 = imageP1 - repmat(mean_p1, [size(imageP1,1), 1]);
    var_p1 = var(Centred_p1);
    sd_p1 = sqrt(var_p1);
    Tp1 = [1/sd_p1(1), 0,0; 0,1/sd_p1(2), 0; 0,0,1]*[1,0,-mean_p1(1);0,1,-mean_p1(2);0,0,1];
    Normalized_p1 = Tp1 * [imageP1'];
    
% processing on the imageP2
    mean_p2 = mean(imageP2);
    Centred_p2 = imageP2 - repmat(mean_p2, [size(imageP2,1), 1]);
    var_p2 = var(Centred_p2);
    sd_p2 = sqrt(var_p2);
    Tp2 = [1/sd_p2(1), 0,0; 0,1/sd_p2(2), 0; 0,0,1]*[1,0,-mean_p2(1);0,1,-mean_p2(2);0,0,1];
    Normalized_p2 = Tp2 * [imageP2]';

    % stacking the equation 
    J = [];
    for i = 1:size(imageP1,1)
        P1 = Normalized_p1(:,i);
        P2 = Normalized_p2(:,i);
        K = [P1(1)*P2(1) P1(2)*P2(1) P2(1) P2(2)*P1(1) P2(2)*P1(2) P2(2) P1(1) P1(2) 1];
        J = [J; K];
    end
    
    %solving for the fundamental matrix

    [U,S,V] = svd(J);
    
    F = V(:,end);
    F_rank3 = reshape(F,[3,3]);
    
    % enforcing the rank 2 condition 
    [U,S,V] = svd(F_rank3);
    S(3,3) = 0 ;
    F_rank2 = U*S*V';

    % undoing the preprocessing process to get the fundamental matrix 
    F_matrix = Tp1' * F_rank2 * Tp2;
end