%load acc
acc_des = csvread('rosbag_data/wrench_cmd.csv',1,1);
%flip xy
acc_des(:,[3 4 6 7]) = -acc_des(:,[3 4 6 7]);
%load cmds
tiltrotor_actuator_cmd = csvread('rosbag_data/tiltrotor_actuator_cmd.csv',1,1);
%align time
min_time = tiltrotor_actuator_cmd(1,1);
tiltrotor_actuator_cmd(:,1) = tiltrotor_actuator_cmd(:,1) - min_time;
acc_des(:,1) = acc_des(:,1) - min_time;
%separate alpha and omega
alpha_cmd = tiltrotor_actuator_cmd(:,1:7);
omega_cmd = tiltrotor_actuator_cmd(:,[1,8:19]);

%%
close all

h = figure()
set(h,'WindowStyle','docked')

subplot(4,1,1)
plot(acc_des(:,2:4))
title('Data - Linear Acceleration')

subplot(4,1,2)
plot(acc_des(:,5:7))
title('Data - Angular Acceleration')

subplot(4,1,3)
plot(alpha_cmd(:,2:6))
title('Data - Angle Commands')

subplot(4,1,4)
plot(omega_cmd(:,2:13))
title('Data - Rotor Speed Commands')

%% Convert Accelerations to Forces

params = parameters();

wrench_des = zeros(size(acc_des));
for i = 1:size(acc_des,1)
    wrench_des(i,1) = acc_des(i,1);
    wrench_des(i,2:7) = accel_to_wrench(acc_des(i,2:7))';
end

%% Old Pipeline

n = size(wrench_des,1);
time = wrench_des(:,1);

A = get_A();


%allocate

alphas_t = zeros(n,7);
omegas_t = zeros(n,13);
wrench_out_t = zeros(n,7);
alphas_t(:,1) = time;
omegas_t(:,1) = time;
wrench_out_t(:,1) = time;

for i = 1:n
    wrench_cmd = wrench_des(i,2:7)';
    
    X = get_X(A,wrench_cmd);
    [alphas, omegas_sq] = get_projections(X);
    
    alphas_t(i,2:7) = alphas';
    omegas_t(i,2:13) = (sqrt(omegas_sq))';
    
    B = get_B(alphas);
    
    wrench_out_t(i,2:7) = (B*omegas_sq)';
end

%% New Pipeline

n = size(wrench_des,1);
time = wrench_des(:,1);

A = get_A();


%allocate

alphas_t = zeros(n,7);
omegas_t = zeros(n,13);
wrench_out_t = zeros(n,7);
alphas_t(:,1) = time;
omegas_t(:,1) = time;
wrench_out_t(:,1) = time;

for i = 1:n
    wrench_cmd = wrench_des(i,2:7)';
    
    X = get_X(A,wrench_cmd);
    [alphas, ~] = get_projections(X);
    
    B = get_B(alphas);
    omegas_sq = get_omegasq(B,wrench_cmd);
    
    alphas_t(i,2:7) = alphas';
    omegas_t(i,2:13) = (sqrt(omegas_sq))';
    
    B = get_B(alphas);
    
    wrench_out_t(i,2:7) = (B*omegas_sq)';
end

%% Plot Accelerations and Wrenches

subplot(4,1,1)
plot(acc_des(:,2:4))
title('Data - Linear Acceleration')

subplot(4,1,2)
plot(wrench_des(:,2:4))
title('Data - Forces')

subplot(4,1,3)
plot(acc_des(:,5:7))
title('Data - Angular Acceleration')

subplot(4,1,4)
plot(wrench_des(:,5:7))
title('Data - Torques')

%% Plot Compare Desired and Allocation

subplot(4,1,1)
plot(wrench_des(:,2:4))
title('Data - Forces')

subplot(4,1,2)
plot(wrench_out_t(:,2:4))
title('Alloc - Forces')

subplot(4,1,3)
plot(wrench_des(:,5:7))
title('Data - Torques')

subplot(4,1,4)
plot(wrench_out_t(:,5:7))
title('Alloc - Torques')

%% Plot Compare Alpha

subplot(4,1,1)
plot(alpha_cmd(:,2:7))
title('Data - Alphas')

subplot(4,1,2)
plot(alphas_t(:,2:7))
title('Alloc - Alphas')

subplot(4,1,3)
plot(omega_cmd(:,2:13))
title('Data - Omegas')
ylim([400,1000])

subplot(4,1,4)
plot(omegas_t(:,2:13))
title('Alloc - Omegas')
ylim([400,1000])