clc

params = parameters();

time = [0:0.01:1]';

alpha_l = zeros(size(time,1),7);
omega_l = zeros(size(time,1),7);

alpha_l(:,1) = time;
omega_l(:,1) = time;

%%

for i = 1:size(time,1)
    
    t = time(i);
    wrench = [30 10*sin(2*pi*t) -9.81*params.mass 0 0 0]';
    
    A = get_A();
    
    X = get_X(A,wrench);
    
    [alphas,~] = get_projections(X);
    
    B = get_B(alphas);
    
    omegas_sq = get_omegasq(B,wrench);
    
    omegas = sqrt(omegas_sq);
    
    wrench_out = B*omegas_sq;
    
    alpha_l(i,2:7) = alphas';
    omega_l(i,2:13) = omegas';

    %plotRotors(h1,alphas,omegas);
    %plotForceTracking(h2,wrench_out,wrench,1);
    
    pause(0.01)
end

%%
for i = 1:size(time,1)
    plotRotors(h1,alpha_l(i,2:7),omega_l(i,2:13));
end