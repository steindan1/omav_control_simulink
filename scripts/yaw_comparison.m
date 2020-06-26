%close all
params = parameters();

% A script to determine custom pitch angles to
% increase torque control authority

%%
bias = 0.1
alpha = bias*((2*pi)/360)*[-1 1 -1 1 -1 1];

%% change spin direction
params.spin = [-1 -1 1 1 -1 -1 1 1 -1 -1 1 1];
%% 
params.spin = [1 1 -1 -1 1 1 -1 -1 1 1 -1 -1];
%%
params.spin = ones(12,1);
%% 
loadviz

hold on
OMAV.setJointPositions(alpha, zeros(3,1), eye(3), eye(3), zeros(12,1))
get_force_cone(alpha, 0.002,eye(3),params);
get_moment_cone(alpha, 0.01,eye(3),params);
hold off

% set view
view(20,20);

%set nice tick labels
scale=0.002;
xt=round(get(gca,'xtick')*(1/scale));
yt=round(get(gca,'ytick')*(1/scale));
zt=round(get(gca,'ztick')*(1/scale));
set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
