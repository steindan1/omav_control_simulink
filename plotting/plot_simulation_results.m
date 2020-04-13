%% clear all but simdata
clearvars -except simOut
close all

%% Check if there is simulation data
try
    simOut;
catch
    error("No simulation data available, check if variable SimOut exists");
end

%% Plot all Data
plotAllData = 1;

figure('Name','Plot All Sim Data')
if plotAllData
    for i = 1:simOut.logsout.numElements
        subplot(simOut.logsout.numElements,1,i)   
        plot(simOut.logsout{i}.Values);
    end
end
set(gcf,'WindowStyle','docked')

%% Compare desired wrench and wrench
compareDesiredWrenchAndWrench = 1;

if compareDesiredWrenchAndWrench
    time_des = simOut.logsout.getElement('wrench_des').Values.time;
    time = simOut.logsout.getElement('wrench').Values.time;
    wrench_des = simOut.logsout.getElement('wrench_des').Values.Data;
    wrench = simOut.logsout.getElement('wrench').Values.Data;

    figure('Name','Compare Wrench and Desired Wrench')
    subplot(2,1,1)
    hold on
    plot(time_des,wrench_des(:,1:3),'linestyle','--','linewidth',1,'color','k')
    plot(time,wrench(:,1:3))
    title('Force Tracking')
    ylabel('Force [N]')
    xlabel('Time [s]')
    grid on
    hold off

    subplot(2,1,2)
    hold on
    plot(time_des,wrench_des(:,4:6),'linestyle','--','linewidth',1,'color','k')
    plot(time,wrench(:,4:6))
    title('Torque Tracking')
    ylabel('Torque [Nm]')
    xlabel('Time [s]')
    grid on
    hold off
end
set(gcf,'WindowStyle','docked')

%% Plot Alphas and Omegas
plotAlphasAndOmegas = 1;

if plotAlphasAndOmegas
    figure('Name','Alphas and Omegas')
    subplot(2,1,1)
    hold on
    simOut.logsout.getElement('alpha_cmd').Values.plot('linestyle','--','color','k')
    simOut.logsout.getElement('alpha').Values.plot()
    hold off
    grid on
    title('Tilt Angle Commands')
    ylabel('Angle [rad]')
    subplot(2,1,2)
    hold on
    simOut.logsout.getElement('omega_cmd').Values.plot('linestyle','--','color','k')
    simOut.logsout.getElement('omega').Values.plot()
    hold off
    grid on
    title('Rotor Speed Commands')
    ylabel('Angular Velocity [rad/s]')
end
set(gcf,'WindowStyle','docked')

%% Plot Rotors at Time t
h = figure()

t_start = 18
t_end = 19
plotRotorsSimOut(h,simOut,t_start, t_end);

