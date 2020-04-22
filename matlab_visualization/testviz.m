%% Load the visualization

% Clear exisint figures
close all; clear all; clear classes; clc;

% Run the loading script
loadviz;

%% Run the test visualization motion

% Initialize a vector of generalized coordinates
q = zeros(6,1);

% Set the sampling time (in seconds)
ts = 0.08;

% Set the duration of the visualization (in seconds)
tf = 10;
kf = tf/ts; % Number of iterations as a function of the duration and the sampling time

% Notify that the visualization loop is starting
disp('Starting visualization loop.');

% Run a visualization loop
for k=1:kf
    %try
        % Start a timer
        startLoop = tic;
        % Set a desired vector of generalized coordinates.
        % We use a discretized version of the sine function.
        
        %set some phase
        phase = ts*50;
        
        
        alpha = sin(2*pi*0.2*k*ts) * ones(6,1);
        p = [0 0 0];
        pitch = 0.2*sin(2*pi*0.2*k*ts);
        roll = 0.2*sin(2*pi*0.2*k*ts + phase);
        yaw = 0.2*sin(2*pi*0.2*k*ts);
        R = eul2rotm([yaw pitch roll]);
        
        %set some omegas
        
        omegas_upper = 1700*(sin(2*pi*0.2*k*ts + phase))^2*ones(6,1);
        omegas_lower = 1700*(sin(2*pi*0.2*k*ts))^2*ones(6,1);
        omegas = zeros(12,1);
        for i=1:6
            omegas(2*i-1) = omegas_upper(i);
            omegas(2*i) = omegas_lower(i);
        end
        
        
        % Set the generalized coordinates to the robot visualizer class
        OMAV.setJointPositions(alpha, p, R, omegas);
        % Update the visualization figure
        drawnow;
        % If enough time is left, wait to try to keep the update frequency
        % stable
        residualWaitTime = ts - toc(startLoop);
        if (residualWaitTime > 0)
            pause(residualWaitTime);
        end
    %catch
        %disp('Exiting the visualization loop.');
        %break;
    %end
end

% Notify the user that the script has ended.
disp('Visualization loop has ended.');

%% 
% EOF