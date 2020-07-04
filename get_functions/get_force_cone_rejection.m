function [] = get_force_cone(alpha,scale,R,params)
    %params = parameters();
    B = get_B(alpha,params);
    %rotate plot
    B = [R*B(1:3,:); R*B(4:6,:)];
    B_pinv = pinv(B);
    max_force = 200;
    step_size = 5;
    
    [F_x, F_y, F_z] = meshgrid(-max_force:step_size:max_force,-max_force:step_size:max_force,-max_force:step_size:max_force);
    F = [F_x(:) F_y(:) F_z(:)];
    
    N = size(F,1);
    F = [F zeros(size(F))];

    F_l = [];
    for i = 1:N
        w = F(i,:)';
        omega_sq = B_pinv*w;
        if (max(omega_sq) <= params.rotor_max.^2 && min(omega_sq) > 0)
            F_l = [F_l;F(i,1:3)];
        end
    end

    %append zero force
    F_l = [F_l;[0 0 0]];

    [k1, av1] = convhull(F_l);
    
    

    s = trisurf(k1,scale*F_l(:,1),scale*F_l(:,2),scale*F_l(:,3),'FaceColor','y','LineStyle','none','FaceAlpha',0.7);
    set(s,'FaceLighting','gouraud');
    
    % Plot main direction
    %main_f = sum(B,2);
    %main_f_scale = 120/norm(main_f);

    %mArrow3([0 0 0],scale*main_f_scale*main_f,'FaceColor','k');
    
    grid on
    axis equal
    view(40,40)
    % xlim([-40 40])
    % zlim([0 140])
    % ylim([-40 40])
    xlabel('F_x [N]')
    ylabel('F_y [N]')
    zlabel('F_z [N]')
%     xt=round(get(gca,'xtick')*(1/scale))
%     yt=round(get(gca,'ytick')*(1/scale))
%     zt=round(get(gca,'ztick')*(1/scale))
%     set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
    %light('Position',50*[0 -1 1],'Style','infinite')
end

