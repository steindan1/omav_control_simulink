function plotForceTracking(fig_handle,wrench_out,wrench_des,subtract_gravity_flag)

%plot parameters
window_dim = 10;
torque_window_dim = 10;
arrow_thickness = 0.2;
tip_thickness = 0.7;

wrench_des = wrench_des(:);
wrench_out = wrench_out(:);

params = parameters();

if subtract_gravity_flag == 1
    gravity_wrench = [0 0 -9.81*params.mass() 0 0 0]';
    wrench_des_plot = wrench_des - gravity_wrench;
    wrench_out_plot = wrench_out - gravity_wrench;
    title_str = 'Wrench Force Tracking, Subtracted Gravity [N]';
else
    wrench_des_plot = wrench_des;
    wrench_out_plot = wrench_out;
    title_str = 'Wrench Force Tracking [N]';
end

%use figure handle
figure(fig_handle);


subplot(2,1,1)
%Plot Setup
plot3(0,0,0)
%plot axes
hold on
mArrow3([0 0 0],[window_dim 0 0],'stemWidth',0.1,'color','k');
text(window_dim, 0, 0, 'x', 'color','k','FontWeight','bold');
mArrow3([0 0 0],[0 window_dim 0],'stemWidth',0.1,'color','k');
text(0, window_dim, 0, 'y', 'color','k','FontWeight','bold');
mArrow3([0 0 0],[0 0 window_dim],'stemWidth',0.1,'color','k');
text(0, 0, window_dim, 'z', 'color','k','FontWeight','bold');
set(gca,'Zdir','reverse','Ydir','reverse');
%set(gca,'Color',[0.8 0.8 0.8]);
axis equal
grid on
view([-50,20])
zlim([-window_dim window_dim])
xlim([-window_dim window_dim])
ylim([-window_dim window_dim])

%Plot Wrench
mArrow3([0 0 0],wrench_des_plot(1:3)','stemWidth',arrow_thickness,'tipWidth',tip_thickness,'color','r','facealpha',0.2);
mArrow3([0 0 0],wrench_out_plot(1:3)','stemWidth',arrow_thickness,'tipWidth',tip_thickness,'color','r');

%Set Title
title(title_str);
hold off

%Lighting
%light('Position',[-1 1 0],'Style','local')

subplot(2,1,2)
window_dim = 20;

plot3(0,0,0)
%plot axes
hold on
mArrow3([0 0 0],[torque_window_dim 0 0],'stemWidth',0.1,'color','k');
text(torque_window_dim, 0, 0, 'x', 'color','k','FontWeight','bold');
mArrow3([0 0 0],[0 torque_window_dim 0],'stemWidth',0.1,'color','k');
text(0, torque_window_dim, 0, 'y', 'color','k','FontWeight','bold');
mArrow3([0 0 0],[0 0 torque_window_dim],'stemWidth',0.1,'color','k');
text(0, 0, torque_window_dim, 'z', 'color','k','FontWeight','bold');
set(gca,'Zdir','reverse','Ydir','reverse');
%set(gca,'Color',[0.8 0.8 0.8]);
axis equal
view([-50,20])
zlim([-torque_window_dim torque_window_dim])
xlim([-torque_window_dim torque_window_dim])
ylim([-torque_window_dim torque_window_dim])
grid on

%Plot Wrench
mArrow3([0 0 0],wrench_des_plot(4:6)','stemWidth',arrow_thickness,'tipWidth',tip_thickness,'color','r','facealpha',0.2);
mArrow3([0 0 0],wrench_out_plot(4:6)','stemWidth',arrow_thickness,'tipWidth',tip_thickness,'color','r');
title('Wrench Torque Tracking [Nm]')
hold off
end

