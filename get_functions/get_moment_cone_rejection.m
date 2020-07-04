function [] = get_moment_cone(alpha,scale,R,params)
    %params = parameters();
    B = get_B(alpha,params);
    %rotate plot
    B = [R*B(1:3,:); R*B(4:6,:)];
    B_pinv = pinv(B);
    max_moment = 10;
    step_size = 0.2;

    [M_x, M_y, M_z] = meshgrid(-max_moment:step_size:max_moment,-max_moment:step_size:max_moment,-max_moment:step_size:max_moment);
    M = [M_x(:), M_y(:), M_z(:)];
    
    N = size(M,1);
    
    f_gravity = (R*[0 0 params.mass*params.gravity]')';
    
    M_l = [];
    for i = 1:N
        w = [f_gravity M(i,:)]';
        omega_sq = B_pinv*w;
        if (max(omega_sq) <= params.rotor_max.^2 && min(omega_sq) > 0)
            M_l = [M_l;M(i,1:3)];
        end
    end

    %append zero moment
    M_l = [[0 0 0];M_l];

    [k1, av1] = convhull(M_l);
    
    

    s = trisurf(k1,scale*M_l(:,1),scale*M_l(:,2),scale*M_l(:,3),'FaceColor','g','LineStyle','none','FaceAlpha',0.7);
    set(s,'FaceLighting','gouraud');
    
    % Plot main direction
    main_m = sum(B,2);
    main_m_scale = 20/norm(main_m);

    %mArrow3([0 0 0],scale*main_m_scale*main_m,'FaceColor','k');
    
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

