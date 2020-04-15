clc
clear all

params = parameters();

%h1 = figure();

for t=0:0.1:pi/2
    wrench = [10*sin(t) 0 -9.81*params.mass 0 0 0]';
    
    A = get_A();
    
    X = get_X(A,wrench);
    
    [alphas,~] = get_projections(X);
    
    B = get_B(alphas);
    
    omegas_sq = get_omegasq(B,wrench);
    
    omegas = sqrt(omegas_sq);
    
    wrench_out = B*omegas_sq;

    plotDominantForce(gcf,alphas,omegas,B);
    %plotRotors(gcf,alphas,omegas);
    %plotForceTracking(gcf,wrench_out,wrench,1);
    
    pause(0.01)
end