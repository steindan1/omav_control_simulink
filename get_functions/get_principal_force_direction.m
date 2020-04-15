function principal_force_direction = get_principal_force_direction(B)

column_sum = sum(B(1:3,:),2);
principal_force_direction = column_sum / norm(column_sum);
end

