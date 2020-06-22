close all

params = parameters();

eul = [0.1 0.5 0];
R = eul2rotm(eul);
f = [0 0 params.mass*params.gravity]';

f_R = R*f;

f_R = [20 0 params.mass*params.gravity]';

A = get_A();

X = get_X(A,[f_R;zeros(3,1)]);

[alpha,~] = get_projections(X);

alpha';

alpha = (pi/4)*[1 -1 1 -1 1 -1];
%
%alpha = 0.001*ones(6,1);

loadviz

hold on
OMAV.setJointPositions(alpha, zeros(3,1), eye(3), eye(3), zeros(12,1))
get_force_cone(alpha, 0.003);
hold off

% set view
view(20,20);

%% set nice tick labels
scale=0.005;
xt=round(get(gca,'xtick')*(1/scale));
yt=round(get(gca,'ytick')*(1/scale));
zt=round(get(gca,'ztick')*(1/scale));
set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)

