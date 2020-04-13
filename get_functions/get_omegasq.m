function omega_sq = get_omegasq(B,wrench_b)
%GET_OMEGASQ Summary of this function goes here
%   Detailed explanation goes here

params = parameters();
omega_sq = pinv(B)*wrench_b;

for i = 1:12
    if omega_sq(i) < 0
        omega_sq(i) = 0;
    end
    
    if omega_sq(i) > (params.rotor_max)^2
        omega_sq(i) = (params.rotor_max)^2;
    end
end

end

