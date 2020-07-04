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
hide_grid = true;
show_force_grid = false;
show_moment_grid = false;
show_force_cone = false;
show_force_cone_rejection = true;
show_moment_cone = false;
show_moment_cone_rejection = true;
show_omegas = false;
custom_alpha = true;
bias = 45; %deg

force_scale = 0.0025;
moment_scale = 0.02;

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
    get_force_cone(alpha, force_scale,R,params)
end

if show_force_cone_rejection == true
    get_force_cone_rejection(alpha,force_scale,R,params)
end

if show_moment_cone == true
    get_moment_cone(alpha, moment_scale,R,params);
end

if show_moment_cone_rejection == true
    get_moment_cone_rejection(alpha,moment_scale,R,params);
end
hold off

% set view
view(20,20);
    
if show_force_grid == true
    %set nice tick labels
    xlabel('F_x [N]')
    ylabel('F_y [N]')
    zlabel('F_z [N]')
    xt=round(get(gca,'xtick')*(1/force_scale));
    yt=round(get(gca,'ytick')*(1/force_scale));
    zt=round(get(gca,'ztick')*(1/force_scale));
    set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
end

if show_moment_grid == true
    %set nice tick labels
    xlabel('M_x [Nm]')
    ylabel('M_y [Nm]')
    zlabel('M_z [Nm]')
    xt=round(get(gca,'xtick')*(1/moment_scale));
    yt=round(get(gca,'ytick')*(1/moment_scale));
    zt=round(get(gca,'ztick')*(1/moment_scale));
    set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
end

if hide_grid == true
    grid off
    set(gca,'visible','off')
end
