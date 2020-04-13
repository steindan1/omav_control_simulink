clc

params = parameters();

alphas = [-0.6478 -0.9869 -0.6478 0.6478 0.9869 0.6478];

h1 = figure();
%h2 = figure();

for t=0:0.05:pi
    wrench = [30 10*sin(t) -9.81*params.mass 0 0 0]';
    
    A = get_A();
    
    X = get_X(A,wrench);
    
    [alphas,~] = get_projections(X);
    
    B = get_B(alphas);
    
    omegas_sq = get_omegasq(B,wrench);
    
    omegas = sqrt(omegas_sq);
    
    wrench_out = B*omegas_sq;

    plotRotors(h1,alphas,omegas);
    %plotForceTracking(h2,wrench_out,wrench,1);
    
    pause(0.01)
end