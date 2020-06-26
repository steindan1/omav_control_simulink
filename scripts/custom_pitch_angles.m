%close all
params = parameters();

% A script to determine custom pitch angles to
% increase torque control authority
%% lock alphas in flight

%set pitch
pitch = 0.2;

%%
eul = [0 pitch 0];
R = eul2rotm(eul);
f = [0 0 params.mass*params.gravity]';

f_R = R'*f;

A = get_A();

X = get_X(A,[f_R;zeros(3,1)]);

[alpha,~] = get_projections(X);

%% set alphas manually

%set alphas 2 and 4 to horizontal
%alpha(2) = -pitch;
%alpha(5) = pitch;

%factor = 1.6;
%set alphas 1 and 6 to something
%alpha(1) = -factor*pitch;
%alpha(6) = factor*pitch;

%alpha(3) = -factor*pitch;
%alpha(4) = factor*pitch;
%alpha = (pi/4)*[1 -1 1 -1 1 -1];
%f_R = [0 0 params.mass*params.gravity]';
%R = eye(3);

%% analytic
alpha = atan(-tan(pitch)./sin(params.arm_angles(1:2:12)));
%% 
loadviz

hold on
OMAV.setJointPositions(alpha, zeros(3,1), R, eye(3), zeros(12,1))
get_force_cone(alpha, 0.002,R);
get_moment_cone(alpha, 0.01,R);
hold off

% set view
view(20,20);

%set nice tick labels
scale=0.002;
xt=round(get(gca,'xtick')*(1/scale));
yt=round(get(gca,'ytick')*(1/scale));
zt=round(get(gca,'ztick')*(1/scale));
set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
