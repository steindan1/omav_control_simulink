function [] = get_force_cone(alpha,scale)
    params = parameters()

    B = get_B(alpha);
    B = B(1:3,:);
    N = 10000;

    F_l = zeros(N,3);
    for i = 1:N
        u = (params.rotor_max*rand(12,1)).^2;
        F_l(i,:) = (B*u)';
    end

    %append zero force
    F_l = [F_l;[0 0 0]];

    [k1, av1] = convhull(F_l);

    trisurf(k1,scale*F_l(:,1),scale*F_l(:,2),scale*F_l(:,3),'FaceColor','y','LineStyle','none','FaceAlpha',0.6);

    % Plot main direction
    main_f = sum(B,2);
    main_f_scale = 120/norm(main_f);

    mArrow3([0 0 0],scale*main_f_scale*main_f,'Color','k');
    
    grid on
    axis equal
    view(40,40)
    % xlim([-40 40])
    % zlim([0 140])
    % ylim([-40 40])
    xlabel('Fx')
    ylabel('Fy')
    zlabel('Fz')
    xt=round(get(gca,'xtick')*(1/scale))
    yt=round(get(gca,'ytick')*(1/scale))
    zt=round(get(gca,'ztick')*(1/scale))
    set(gca,'xticklabel',round(xt),'yticklabel',yt,'zticklabel',zt)
    %light('Position',50*[0 -1 1],'Style','infinite')
end

