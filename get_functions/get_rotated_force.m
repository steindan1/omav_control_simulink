function B_f_c = get_rotated_force(alpha,R,I_f_r)
%GET_ROTATED_FORCE Summary of this function goes here
%   Detailed explanation goes here

params = parameters();

clf
hold on
plot3(0,0,0)
title('Reference Orientation Frame')

% get force vector in body frame
B_f_r = R'*I_f_r;

% plot body coordinate system
quiver3(zeros(3,1),zeros(3,1),zeros(3,1),[1 0 0]',[0 1 0]',[0 0 1]','Color','k')

% get allocation matrix from tilt-angles
B = get_B(alpha);

% sum columns to get main force direction
B_sum = sum(B(1:3,:),2);

% normalize to get unit vector
e_alpha = B_sum / norm(B_sum);

mArrow3([0 0 0],e_alpha)

% get rotation matrix which to frame with e_alpha as 3rd axis
u = [0 0 1]';
v = e_alpha;

chi = 2*atan2(norm(norm(v)*u-norm(u)*v),norm(norm(v)*u+norm(u)*v));
n = cross(u,v);
axang = [n' chi];

if chi < 0.0001
    R_alpha = eye(3);
else
    R_alpha = axang2rotm(axang);
end
quiver3(zeros(1,3),zeros(1,3),zeros(1,3),R_alpha(1,:),R_alpha(2,:),R_alpha(3,:),'Color','b')

mArrow3([0 0 0],B_f_r/norm(B_f_r),'color','r')

% get angle between e_alpha and B_f_r
u = e_alpha;
v = B_f_r;

lambda_r = 2*atan2(norm(norm(v)*u-norm(u)*v),norm(norm(v)*u+norm(u)*v));
n = cross(u,v);

% bisection search
B_pinv = pinv(B);
omega_sq_max = (params.rotor_max)^2;
omega_sq_min = 0;
tol = 1e-5;

max_iter = 10;

lambda_min = 0;
lambda = lambda_min;

k=0;
delta = inf;
while delta > 0.01 && k < max_iter 
    fprintf('iter %d, lambda: %.2f \n',k,lambda);
    
    axang = [n' lambda];
    R_s = axang2rotm(axang);
    B_R_s = R_alpha*R_s;
    
    B_f_c = B_R_s*B_f_r;
    
    mArrow3([0 0 0],B_f_c/norm(B_f_c));
    
    %quiver3(zeros(1,3),zeros(1,3),zeros(1,3),r_R_s(1,:),r_R_s(2,:),r_R_s(3,:),'Color','g')
    
    omega_sq = B_pinv * [R_s'*B_f_r;zeros(3,1)];
    
    %limit to positive values
    omega_sq = max(0,omega_sq);
    
    %limit to max rotor speed
    omega_sq = min(omega_sq_max,omega_sq);
    
    e_f = norm(B*omega_sq - [R_s'*B_f_r;zeros(3,1)]);
    
    if e_f < tol && max(omega_sq) < omega_sq_max && min(omega_sq) > omega_sq_min
        delta = 0.5*(lambda-lambda_min);
        lambda = lambda - delta;
    else
        lambda_min = lambda;
        delta = 0.5*(lambda_r - lambda);
        lambda = lambda + delta;
    end
    
    %print iteration result
    fprintf('iter %d, e_f: %d, omega_max: %.f, omega_min %.f \n\n',k,e_f,max(sqrt(omega_sq)),min(sqrt(omega_sq)));
    
    %increment loop counter
    k=k+1;
end

axis equal
xlim([-1 1])
ylim([-1 1])
zlim([-1 1])
view([140 30])

grid on

hold off

end
