function wasted_force_index = get_wasted_force_index(wrench_force,omega)
params = parameters();

wasted_force_index = norm(wrench_force)/sum(params.rotor_force_constant*omega.^2);
end

