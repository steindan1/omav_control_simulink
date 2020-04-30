function B = get_B_analytical()
%tilt_angles [6x1]
%[F, tau] = B * [omega²]

params = OMAVparameters();

rotor_force_constant = params.rotor_force_constant;
rotor_moment_constant = params.rotor_moment_constant;
arm_length = params.arm_length;

arm_angles = params.arm_angles;
spin = params.spin;

B = sym('b', [6 12]);
alphas = sym('alpha', [1,6]);

%repeat every tilt angle
rep_tilt_angles = repelem(alphas,2);


for i=1:12  
    tilt_angle = rep_tilt_angles(i);
    
    B(1,i) = sin(arm_angles(i))*sin(tilt_angle);
    B(2,i) = -cos(arm_angles(i))*sin(tilt_angle);
    B(3,i) = cos(tilt_angle);
    B(4,i) = -(rotor_moment_constant*spin(i)*sin(tilt_angle) - cos(tilt_angle)*arm_length)*sin(arm_angles(i));
    B(5,i) =  (rotor_moment_constant*spin(i)*sin(tilt_angle) - cos(tilt_angle)*arm_length)*cos(arm_angles(i));
    B(6,i) = -(rotor_moment_constant*spin(i)*cos(tilt_angle) + sin(tilt_angle)*arm_length);
end

B = B*rotor_force_constant;
end