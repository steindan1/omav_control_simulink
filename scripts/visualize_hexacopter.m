%%
clear,clc
%%
params = parameters();
[tout,] = sim('hexacopter_omav');

N = size(tout,1);
ts = mean(diff(tout));
ts_viz = 0.1;

t_viz_ix = [1:ts_viz/ts:N]';

kf = size(t_viz_ix,1);
%%
loadviz;
axis(OMAV.vizAx_, 4*[-1 1 -1 1 0 2])
campos([7.5865  -32.7768   10.3846]);
camtarget([1.4461    0.2189    1.8067]);
grid(gca);
%%
alpha = zeros(6,1);
omegas = zeros(12,1);

for k=1:kf
    startLoop = tic;
    
    t_idx = t_viz_ix(k);
    omegas = (1700/600)*repelem(getdatasamples(logsout{2}.Values,t_idx),2);
    R = getdatasamples(logsout{1}.Values,t_idx);
    p = getdatasamples(logsout{3}.Values,t_idx);
    %p=[0 0 0];
    
    OMAV.setJointPositions(alpha, p, R, omegas);
    % Update the visualization figure
    drawnow;
    % If enough time is left, wait to try to keep the update frequency
    % stable
    residualWaitTime = ts_viz - toc(startLoop);
    if (residualWaitTime > 0)
        pause(residualWaitTime);
    end
end



