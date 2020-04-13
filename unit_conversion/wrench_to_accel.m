function accel = wrench_to_accel(wrench)

wrench = wrench(:);
params = parameters();

accel = zeros(6,1);

accel(1:3) = wrench(1:3)*params.mass;
accel(4:6) = params.inertia\wrench(4:6);
end

