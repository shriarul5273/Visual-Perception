clc
clear all

% Loading the world coordinates
checkerboardpoints = load('ptsXY.txt');
checkerboardpoints(:,3) = 1;

L = [];

% estimating the homography for each image
for j = 1:10
    fileName = append('pts2D_',int2str(j),'.txt');
    imagePoints = load(fileName);
    imagePoints(3,:) = 1;
    A = [];
    for i = 1:100
%         stacking the point equation
        alphax = [-checkerboardpoints(i,:),0,0,0,(imagePoints(1,i).*checkerboardpoints(i,:))];
        A = vertcat(A,alphax);
        alphay = [0,0,0,-checkerboardpoints(i,:),(imagePoints(2,i).*checkerboardpoints(i,:))];
        A = vertcat(A,alphay);
    end
    % estamating the Homography
    [U,S,V] = svd(A);

    J = V(:,end);
    A = J(1:3)';
    B = J(4:6)';
    C = J(7:9)';   
    H = [A;B;C];
    
    
    % stacking the v vector
    L= vertcat(L ,[getV(H,1,2)';
     (getV(H,1,1)-getV(H,2,2))']);

end

%computing the B matrix 
[U,S,V] = svd(L);
B =V(:,end);

% computing the parameters
vo = (B(2)*B(4)-B(1)*B(5))/(B(1)*B(3)-B(2)^2) ;
lambda = B(6)- ((B(4)^2+vo*(B(2)*B(4)-B(1)*B(5)))/B(1));
alpha = sqrt(lambda/B(1));
beta = sqrt((lambda*B(1))/(B(1)*B(3)-B(2)^2));
gamma = -B(2)*alpha^2*beta/lambda;
uo = (gamma*vo/beta)-(B(4)*alpha^2/lambda);


% rearraing to get the K matrix
K = [alpha gamma uo;
    0   beta vo;
    0    0     1]

