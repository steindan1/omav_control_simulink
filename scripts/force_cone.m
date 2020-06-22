params = parameters()
clf
hold on
for k = [pi/3]
    
    alpha = k*[-1 -1 1 1 1 1];
    B = get_B(alpha);
    B = B(1:3,:);
    N = 100000;

    F_l = zeros(N,3);
    for i = 1:N
        u = (params.rotor_max*rand(12,1)).^2;
        F_l(i,:) = (B*u)';
    end

    %append zero torque
    F_l = [F_l;[0 0 0]];

    [k1, av1] = convhull(F_l);

    trisurf(k1,F_l(:,1),F_l(:,2),F_l(:,3),'FaceColor','y','LineStyle','none','FaceAlpha',0.7);
    
    % Plot main direction
    main_f = sum(B,2);
    main_f_scale = 120/norm(main_f);
    
    mArrow3([0 0 0],main_f_scale*main_f);
    
    % Plot cone
    % cone slope
    a = 1.7/k^1.2
    
    % cone angle
    beta = asin(1/a);
    

    r = linspace(0,40) ;
    th = linspace(0,2*pi) ;
    [R,T] = meshgrid(r,th) ;
    X = R.*cos(T) ;
    Y = R.*sin(T) ;
    Z = a*R;
    %surf(X,Y,Z,'FaceAlpha',0.7,'LineStyle','none')
end
hold off

grid on
axis equal
view(40,40)
% xlim([-40 40])
% zlim([0 140])
% ylim([-40 40])
xlabel('Fx')
ylabel('Fy')
zlabel('Fz')
light('Position',50*[0 -1 1],'Style','infinite')
