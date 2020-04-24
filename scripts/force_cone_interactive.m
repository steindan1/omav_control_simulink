close all

addpath('parameter_files');
addpath('get_functions');
addpath('plotting');


% hold on

figures = [figure,figure];

arm_no = 1;
alpha = 0;

% Set up tilt arm sliders:
fig = uifigure;
for i=1:6
    x = 10;
    y = 20 + i * 50;
    sld(i) = uislider(fig,'ValueChangingFcn',@(sld,event) updateForceCone(figures,event.Value,i),'Position',[x,y,100,10]);
    sld(i).Limits = [-pi pi];
    sld(i).Value = 0;
end

for k = [pi/6]
    
    global alphas
    alphas = k*[1 -1 1 -1 1 -1];
    alpha = 0;
    updateForceCone(figures,alpha,1);
    
end

% figure(figures(1))
% title("Forces")
% grid on
% axis equal
% view(40,40)
% xlim([-40 40])
% zlim([0 40])
% ylim([-40 40])
% xlabel('Fx')
% ylabel('Fy')
% zlabel('Fz')
% light('Position',50*[0 -1 1],'Style','infinite')
% 
% 
% figure(figures(2))
% title("Moments")
% grid on
% axis equal
% view(40,40)
% xlim([-40 40])
% zlim([-40 40])
% ylim([-40 40])
% xlabel('Mx')
% ylabel('My')
% zlabel('Mz')
% light('Position',50*[0 -1 1],'Style','infinite')
