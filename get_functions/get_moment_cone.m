function [] = get_moment_cone(alpha,scale,R)
    params = parameters();
    B = get_B(alpha);
    %rotate plot
    B = R*B(4:6,:);
    N = 100000;

    M_l = zeros(N,3);
    for i = 1:N
        u = (params.rotor_max*rand(12,1)).^2;
        M_l(i,:) = (B*u)';
    end

    %append zero force
    M_l = [[0 0 0];M_l];

    [k1, av1] = convhull(M_l);
    
    

    s = trisurf(k1,scale*M_l(:,1),scale*M_l(:,2),scale*M_l(:,3),'FaceColor','g','LineStyle','none','FaceAlpha',0.5);
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

