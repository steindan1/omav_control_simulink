%close all

params = parameters();

%% lock alphas in flight
eul = [0 pi/6 0];
R = eul2rotm(eul);
f = [0 0 params.mass*params.gravity]';

f_R = R'*f;



A = get_A();

X = get_X(A,[f_R;zeros(3,1)]);

[alpha,~] = get_projections(X);

%% set alphas manually

alpha = (pi/4)*[1 -1 1 -1 1 -1];
f_R = [0 0 params.mass*params.gravity]';
R = eye(3);

%% 
loadviz

hold on
OMAV.setJointPositions(alpha, zeros(3,1), R, eye(3), zeros(12,1))
get_force_cone(alpha, 0.003,R);
get_moment_cone(alpha, 0.01,R);
hold off

% set view
view(20,20);

%set nice tick labels
scale=0.005;
xt=round(get(gca,'xtick')*(1/scale));
yt=round(get(gca,'ytick')*(1/scale));
zt=round(get(gca,'ztick')*(1/scale));
set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)

