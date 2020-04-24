function wrench = accel_to_wrench(accel)

accel = accel(:);
params = OMAVparameters();

wrench = zeros(6,1);

wrench(1:3) = accel(1:3)*params.mass;
wrench(4:6) = params.inertia*accel(4:6);
end

