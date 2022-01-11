function V = getV(H,i,j)
%% getV
%         Rearranges the Homography matrix
%   Input
%       H - Homography matrix
%       i - Index
%       j - index
%
%   Output
%       V - Rearranged form of H
%% Function starts here
    V =[H(1,i)*H(1,j);
        H(1,i)*H(2,j)+H(2,i)*H(1,j);
        H(2,i)*H(2,j);
        H(3,i)*H(1,j)+H(1,i)*H(3,j);
        H(3,i)*H(2,j)+H(2,i)*H(3,j);
        H(3,i)*H(3,j)];
end