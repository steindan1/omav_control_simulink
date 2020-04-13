function [] = plotRotorsSimOut(h,simOut,t_start,t_end)
    time = simOut.logsout.getElement('alpha').Values.time;

    try
        t_idx_list = find(time > t_start & time < t_end);
    catch
        error("Index could not be found");
    end
    
    for i = 1:size(t_idx_list)
        t_idx = t_idx_list(i);
        
        alpha_t = simOut.logsout.getElement('alpha').Values.Data(t_idx,:);
        omega_t = simOut.logsout.getElement('omega').Values.Data(t_idx,:);

        plotRotors(h,alpha_t,omega_t)
        plotRotors(h,alpha_t,omega_t)
        
        pause(0.01)
    end
end

