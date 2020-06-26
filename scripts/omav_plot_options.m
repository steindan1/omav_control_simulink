%close all
params = parameters();

% A script to determine custom pitch angles to
% increase torque control authority
%%
pitch = 0;
roll = 0;

eul = [0 pitch roll];
R = eul2rotm(eul);
f = [0 0 params.mass*params.gravity]';

f_R = R'*f;

A = get_A(params);

X = get_X(A,[f_R;zeros(3,1)]);

[alpha,omega_sq] = get_projections(X);

omegas = sqrt(max(0,omega_sq));

%% plot options
show_grid = false;
show_force_cone = true;
show_moment_cone = true;
show_omegas = false;
custom_alpha = true;
bias = 25; %deg

if custom_alpha == true
    alpha = bias*((2*pi)/360)*[1 -1 1 -1 1 -1];
end
%% 
loadviz

hold on
if show_omegas == true
    OMAV.showOmegaVecs_ = 1;
end

OMAV.setJointPositions(alpha, zeros(3,1), R, eye(3), omegas)

if show_force_cone == true
    get_force_cone(alpha, 0.002,R,params)
end

if show_moment_cone == true
    get_moment_cone(alpha, 0.007,R,params);
end
hold off

% set view
view(20,20);
    
if show_grid == true
    %set nice tick labels
    scale=0.002;
    xt=round(get(gca,'xtick')*(1/scale));
    yt=round(get(gca,'ytick')*(1/scale));
    zt=round(get(gca,'ztick')*(1/scale));
    set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
else
    grid off
    set(gca,'visible','off')
end 
