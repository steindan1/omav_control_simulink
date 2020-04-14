function plotDominantForce(fig_handle,alphas,omegas,B)

params = parameters();
omega_scale = 0.3;

omegas = omega_scale*(omegas/params.rotor_max);

params = parameters();
arm_angles = params.arm_angles();
arm_length = params.arm_length();

figure(fig_handle);

%create points
arms = zeros(6,3);
plot3(0,0,0)
%plot axes
hold on
mArrow3([0 0 0],[0.4 0 0],'stemWidth',0.001,'color','k');
text(0.4, 0, 0, 'x', 'color','k','FontWeight','bold');
mArrow3([0 0 0],[0 0.4 0],'stemWidth',0.001,'color','k');
text(0, 0.4, 0, 'y', 'color','k','FontWeight','bold');
mArrow3([0 0 0],[0 0 0.4],'stemWidth',0.001,'color','k');
text(0, 0, 0.4, 'z', 'color','k','FontWeight','bold');
set(gca,'Zdir','reverse','Ydir','reverse');
%set(gca,'Color',[0.8 0.8 0.8]);
axis equal
view([-50,20])
zlim([-0.4 0.4])
xlim([-0.4 0.4])
ylim([-0.4 0.4])
grid on
for i = 1:6
    IR_T = [cos(arm_angles(2*i-1)) -sin(arm_angles(2*i-1)) 0 arm_length*cos(arm_angles(2*i-1));
        sin(arm_angles(2*i-1)) cos(arm_angles(2*i-1)) 0 arm_length*sin(arm_angles(2*i-1));
        0                       0                     1             0;
        0                       0                     0             1];
    
    R_r_1 = [0 ; omegas(2*i-1)*sin(alphas(i)); -omegas(2*i-1)*cos(alphas(i)); 1];
    R_r_2 = [0 ; omegas(2*i)*sin(alphas(i)); -omegas(2*i)*cos(alphas(i)); 1];
    
    R_r_alpha = [0;sin(alphas(i));-cos(alphas(i));1];
    R_r_unit = [0;omega_scale*sin(alphas(i));-omega_scale*cos(alphas(i));1];
    
    I_r_IR = IR_T(:,4);
    
    I_r_01 = IR_T*R_r_1;
    I_r_02 = IR_T*R_r_2;
    I_r_unit = IR_T*R_r_unit;
    I_r_alpha = IR_T*R_r_alpha;
    
    circle_normal = I_r_alpha(1:3)'-I_r_IR(1:3)';
    
    plot3([0;I_r_IR(1)],[0;I_r_IR(2)],[0;I_r_IR(3)],'color','k','linewidth',3);
    plotCircle3D(I_r_IR(1:3)',circle_normal,0.1,'k');
    mArrow3(I_r_IR(1:3),I_r_01(1:3),'stemWidth',0.005,'tipWidth',0.015,'color','b');
    mArrow3(I_r_IR(1:3),I_r_02(1:3),'stemWidth',0.005,'tipWidth',0.015,'color','r');
    mArrow3(I_r_IR(1:3),I_r_unit(1:3),'stemWidth',0.001,'tipWidth',0,'color','k');
    mArrow3(I_r_IR(1:3),I_r_unit(1:3),'stemWidth',0.001,'tipWidth',0,'color','k');
    
    %Plot dominant force
    %compute vector
    I_d = sum(B(1:3,:),2);
    I_d = omega_scale*(I_d / norm(I_d));
    
    %plot
    mArrow3([0 0 0],I_d,'stemWidth',0.005,'tipWidth',0.015,'color','g');
    
end

light('Position',[-1 0 0])
hold off
