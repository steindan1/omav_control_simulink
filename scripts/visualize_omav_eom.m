%%
%%clear,clc
%%
params = OMAVparameters();
simOut = sim('omav_noise_LBF_bisection_combined');

logsout = simOut.logsout;

tout = simOut.tout;

N = size(tout,1);
ts = mean(diff(tout));
ts_viz = 0.1;

t_viz_ix = [1:ceil(ts_viz/ts):N]';

kf = size(t_viz_ix,1);
%%
loadviz;
axis(OMAV.vizAx_,[-1.4406    1.8005   -2.2260    1.0150   -1.3271    1.9180])
campos([5.1582  -27.3560    7.2325]);
camtarget([0.1800   -0.6055    0.2955]);
grid(gca);
%%
 
for k=1:kf
    startLoop = tic;
    
    t_idx = t_viz_ix(k);
    omegas = getdatasamples(logsout.getElement('omega').Values,t_idx);
    R = getdatasamples(logsout.getElement('R').Values,t_idx);
    R_d = getdatasamples(logsout.getElement('R_d').Values,t_idx);
    p = getdatasamples(logsout.getElement('p').Values,t_idx);
    alpha = getdatasamples(logsout.getElement('alpha').Values,t_idx);
    %p=[0 0 0];
    
    OMAV.setJointPositions(alpha, p, R, R_d, omegas);
    % Update the visualization figure
    drawnow;
    % If enough time is left, wait to try to keep the update frequency
    % stable
    residualWaitTime = ts_viz - toc(startLoop);
    if (residualWaitTime > 0)
        pause(residualWaitTime);
    end
end
