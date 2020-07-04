%close all
params = parameters();

% A script to determine custom pitch angles to
% increase torque control authority

%% plot options
show_grid = false;
show_force_cone = true;
show_moment_cone = true;
show_omegas = false;
custom_alpha = false;
analytic_alpha = false;
bias = 30; %deg

wasted_force_index_array = [];
force_volume_array = [];
moment_volume_array = [];
bias_array = linspace(0.01,30);
for bias = bias_array
    alpha = bias*((2*pi)/360)*[1 -1 1 -1 1 -1];

    pitch = 0;
    roll = 0;

    eul = [0 pitch roll];
    R = eul2rotm(eul);
    f = [0 0 params.mass*params.gravity]';

    f_R = R'*f;

    A = get_A(params);
    B = get_B(alpha,params);


    omega_sq = pinv(B)*[f_R;zeros(3,1)];

    omegas = sqrt(max(0,omega_sq));

    wasted_force_index = get_wasted_force_index(f_R,omegas);
    force_volume = get_force_cone(alpha,0,eye(3),params);
    moment_volume = get_moment_cone(alpha,0,eye(3),params);
    
    wasted_force_index_array = [wasted_force_index_array wasted_force_index];
    force_volume_array = [force_volume_array force_volume];
    moment_volume_array = [moment_volume_array moment_volume];
    close all
end
%%
figure
subplot(3,1,1)
plot(bias_array,wasted_force_index_array,'LineWidth',2)
title('Wasted force index')
grid on
subplot(3,1,2)
plot(bias_array,force_volume_array,'Color','#FFA500','LineWidth',2)
ylabel('[N^3]')
title('Force control volume')
grid on
subplot(3,1,3)
plot(bias_array,moment_volume_array,'Color','#66cd00','LineWidth',2)
title('Torque control volume')
xlabel('Tilt angle [deg]')
ylabel('[Nm^3]')
grid on
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
