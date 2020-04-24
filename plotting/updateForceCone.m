function updateForceCone(figs,alpha,arm_no)
%     alpha = k*[1 -1 1 -1 1 -1];
    global alphas
    params = OMAVparameters();
    
    alphas(arm_no) = alpha;
    B = get_B(alphas);
    B_forces = B(1:3,:);
    B_moments = B(4:6,:);
    N = 100000;

    F_l = zeros(N,3);
    M_l = zeros(N,3);
    for i = 1:N
        u = (params.rotor_max*rand(12,1)).^2;
        F_l(i,:) = (B_forces*u)';
        M_l(i,:) = (B_moments*u)';
    end

    %append zero force
    F_l = [F_l;[0 0 0]];

    [k1, av1] = convhull(F_l);
    [k2, av2] = convhull(M_l);

    
    % Plot cone
    % cone slope
%     a = 1.7/k^1.2
%     a = 0
%     
%     % cone angle
%     beta = asin(1/a);
% 
%     r = linspace(0,80) ;
%     th = linspace(0,2*pi) ;
%     [R,T] = meshgrid(r,th) ;
%     X = R.*cos(T) ;
%     Y = R.*sin(T) ;
%     Z = a*R;
%     figure(figs(1))
%     surf(X,Y,Z,'FaceAlpha',0.7,'LineStyle','none')
    figure(figs(1))
    trisurf(k1,F_l(:,1),F_l(:,2),F_l(:,3),'FaceColor','y','LineStyle','none','FaceAlpha',0.7);
    title("Forces")
    grid on
    axis equal
    view(40,40)
    xlim([-40 40])
    zlim([0 40])
    ylim([-40 40])
    xlabel('Fx')
    ylabel('Fy')
    zlabel('Fz')
    light('Position',50*[0 -1 1],'Style','infinite')


    figure(figs(2))
    trisurf(k2,M_l(:,1),M_l(:,2),M_l(:,3),'FaceColor','y','LineStyle','none','FaceAlpha',0.7);
    title("Moments")
    grid on
    axis equal
    view(40,40)
    xlim([-40 40])
    zlim([-40 40])
    ylim([-40 40])
    xlabel('Mx')
    ylabel('My')
    zlabel('Mz')
    light('Position',50*[0 -1 1],'Style','infinite')
    
end

