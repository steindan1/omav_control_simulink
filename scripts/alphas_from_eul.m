close all

params = parameters();

eul = [0.1 0.5 0];
R = eul2rotm(eul);
f = [0 0 params.mass*params.gravity]';

f_R = R*f;

f_R = [0 0 9.81]';

A = get_A();

X = get_X(A,[f_R;zeros(3,1)]);

[alpha,~] = get_projections(X);

alpha';

loadviz

hold on
OMAV.setJointPositions(alpha, zeros(3,1), eye(3), eye(3), zeros(12,1))
get_force_cone(alpha, 0.003);
hold off