% Maximize lateral x-capability
alphas = [1,0,-1,1,0,1]*0.0

omega_ref = 4.6e5;

B = get_B(alphas);
B_grad = get_B_gradient(alphas);

K = eye(12)*1.01;

d_alpha = pinv(B_grad) * B * (inv(K)-eye(12))

% B_inv = pinv(B)
% B_inv_grad = pinv(B_grad)
% 
% df = 0.001;
% 
% F_minus = [-df,0,40,0,0,0]';
% F_plus = [df,0,40,0,0,0]';
% 
% omega_minus = B_inv * F_minus
% omega_plus = B_inv * F_plus
% 
% % For each arm, check in what direction the resulting omega is out of
% % physical bounds and rotate arm a little bit to be get closer to physical
% % range (i.e. bring it to omega_ref)
% 
% % For omega_plus: Iterate and adapt alpha slightly:
% % for i=1:12
% %     
% 
% F_minus_res = B * omega_minus
% F_plus_res = B * omega_plus
% loadviz;
% 
% R = eye(3);
% p = [0,0,0];
% omegas = zeros(12,1);
% OMAV.setJointPositions(alphas, p, R, omegas);