clc
clear

alpha = zeros(6,1);
B = get_B(alpha);

t = 0.1;
wrench = [0 0 9.81*4.95 0 0 t]';

Omega = pinv(B)*wrench;
Omega = max(0,Omega);

omega = sqrt(Omega)