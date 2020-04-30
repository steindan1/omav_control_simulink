function alphas = get_alphasFromPrincipalDirection(principal_direction)
%GET_ALPHASFROMPRINCIPALDIRECTION Summary of this function goes here
%   Detailed explanation goes here
A = get_A();
wrench = [principal_direction;0;0;0];
x = pinv(A)*wrench;
alphas = get_projections(x);
end

