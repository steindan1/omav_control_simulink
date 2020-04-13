function A = get_A()
%[F, tau] = A * [sin(alpha)*omega², cos(alpha)*omega²]

params = parameters();

rotor_force_constant = params.rotor_force_constant;
rotor_moment_constant = params.rotor_moment_constant;
arm_length = params.arm_length;

arm_angles = params.arm_angles;
spin = params.spin;

%implementing pre-calculated matrix
%zero entries are commented out
A = zeros(6,24);

%iterating through every rotor
for i = 1:12
    A(1,2*i-1) = -sin(arm_angles(i));
    %A(1,2*i) = 0;
    
    A(2,2*i-1) = cos(arm_angles(i));
    %A(2,2*i) = 0;
    
    %A(3,2*i-1) = 0;
    A(3,2*i) = -1;
    
    A(4,2*i-1) = -rotor_moment_constant*spin(i)*sin(arm_angles(i));
    A(4,2*i) = -sin(arm_angles(i))*arm_length;
    
    A(5,2*i-1) = rotor_moment_constant*spin(i)*cos(arm_angles(i));
    A(5,2*i) = cos(arm_angles(i))*arm_length;
    
    A(6,2*i-1) = arm_length;
    A(6,2*i) = -rotor_moment_constant*spin(i);
end

%multiplying with rotor force constant
A = A*rotor_force_constant;
