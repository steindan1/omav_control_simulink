%% clear
clear all
clc

%% load parameters
params = parameters();

%% load simulation input and reference
%1000 simulation points
t_end = 5;
t_step = 0.01;
n = t_end/t_step;
time = 0:t_step:t_end-t_step;
wrench_des = zeros(n,7);
wrench_des(:,1) = time';

for i = 1:n
    t = time(i);
    acc_des = [10*sin(5*t) 0 -9.81 0 0 0];
    wrench_des(i,2:7) = accel_to_wrench(acc_des)';
end


%% start simulation
%simOut = sim('omav_allocation');
simOut = sim('omav_B_matrix');
disp('Simulation complete, results in workspace')