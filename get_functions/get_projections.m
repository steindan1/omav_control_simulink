function [alphas, omegas_sq] = get_projections(X)
%GET_PROJECTIONS Summary of this function goes here
%   Detailed explanation goes here


%get the angles
alphas = zeros(6,1);
for i = 1:6
    %get to entry which corresponds to arm
    j = 4*i - 3;
    alphas(i) = atan2(X(j)+X(j+2),X(j+1)+X(j+3));
end

omegas_sq = zeros(12,1);
for i = 1:6
    %get to entry which corresponds to arm
    j = 4*i - 3;
    
    omegas_sq(2*i-1) = X(j)*sin(alphas(i)) + X(j+1)*cos(alphas(i));
    omegas_sq(2*i)   = X(j+2)*sin(alphas(i)) + X(j+3)*cos(alphas(i));
end

%set to zero if smaller than zero
for i = 1:12
    if omegas_sq(i) < 0
        omegas_sq(i) = 0;
    end
end
    

