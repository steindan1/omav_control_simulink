function params = parameters()
%loads all parameters

% F = rotor_force_constant * omega^2
params.rotor_force_constant = 0.00000723288;

% tau = rotor_force_constant * rotor_moment_constant * omega^2
params.rotor_moment_constant = 0.015;

% arm length
params.arm_length = 0.3;

params.inertia = diag([0.078359127 0.081797886 0.1533554115]); %inertia
params.inertia_inv = inv(diag([0.078359127 0.081797886 0.1533554115]));

params.mass = 4.04; %mass
params.gravity = 9.81; %gravity
params.rotor_max = 1700.0; %Max angular velocity of rotor [rad/s]^2

%Maximum rate at which the servos will be commanded to turn (rads per second)
%physical limit: 8.0 rad/s
params.servo_max = 1; 

% arm angles [rad]
% assuming z-axis pointing downwards
% angles positive around z-axis
% i:    top rotor
% i+1:  bottom rotor

params.arm_angles = [1/6 1/6 1/2 1/2 5/6 5/6 7/6 7/6 3/2 3/2 11/6 11/6]*pi;

% spin direction [-1, 1]
% assuming z-axis pointing downwards
% spin direction positive around z-axis for tilt angles zero
% i:    top rotor
% i+1:  bottom rotor
% spin results to zero in both z-planes

params.spin = [1 -1 -1 1 1 -1 -1 1 1 -1 -1 1];

%%%%%%%%%%% CONTROL %%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%% A - Allocation %%%%%%%%%%%%%
%Attitude
params.A_attitude_Kp = 0.1*[6; 6; 6]; %Kp attitude controller
params.A_attitude_Kd = 0.1*[1; 1; 1]; %Kd attitude controller

%Position
params.A_position_Kp = 0.1*[90; 90; 90]; %Kp position controller
params.A_position_Kd = 0.1*[25; 25; 25]; %Kd position controller

%%%%%%%%%%% B - Allocation %%%%%%%%%%%%%
%Attitude
params.B_attitude_Kp = 40*[5; 5; 5]; %Kp attitude controller
params.B_attitude_Kd = 20*[1; 1; 1]; %Kd attitude controller

%Position
params.B_position_Kp = 3*[5; 5; 5]; %Kp position controller
params.B_position_Kd = 3*[2; 2; 2]; %Kd position controller


%%%%%%%%%%% SIMULATION %%%%%%%%%%%%%%%%%%
params.sampling_time = 0.01;
end

