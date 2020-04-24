%% clear
clear all
clc

%% load parameters
params = OMAVparameters();

%% load simulation input and reference
%load acc
acc_des = csvread('rosbag_data/wrench_cmd.csv',1,1);
%flip xy
acc_des(:,[3 4 6 7]) = -acc_des(:,[3 4 6 7]);
%convert to wrench
wrench_des = zeros(size(acc_des));
wrench_des(:,1) = acc_des(:,1);
for i = 1:size(acc_des,1)
    wrench_des(i,2:7) = accel_to_wrench(acc_des(i,2:7))';
end

%load cmds
tiltrotor_actuator_cmd = csvread('rosbag_data/tiltrotor_actuator_cmd.csv',1,1);
%align time
min_time = tiltrotor_actuator_cmd(1,1);
tiltrotor_actuator_cmd(:,1) = tiltrotor_actuator_cmd(:,1) - min_time;
wrench_des(:,1) = wrench_des(:,1) - min_time;
%separate alpha and omega
alpha_cmd_rosbag = tiltrotor_actuator_cmd(:,1:7);
omega_cmd_rosbag = tiltrotor_actuator_cmd(:,[1,8:19]);

%% start simulation
%simOut = sim('omav_allocation');
simOut = sim('omav_B_matrix');
disp('Simulation complete, results in workspace')