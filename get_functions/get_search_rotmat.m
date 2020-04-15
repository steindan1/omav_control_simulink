function B_search_rotmat = get_search_rotmat(reference_force,principal_force_direction)
%rotmat is in body frame

f_r = reference_force(:);
e_alpha = principal_force_direction(:);

angle = acos(dot((f_r/norm(f_r))',e_alpha));

u = cross(e_alpha, f_r);

axang = [u;angle]';

B_search_rotmat = axang2rotm(axang);
end

