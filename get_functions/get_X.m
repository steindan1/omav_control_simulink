function X = get_X(A,wrench_b)
%GET_X Summary of this function goes here
%   Detailed explanation goes here
wrench_b = wrench_b(:);

X = pinv(A)*wrench_b;
end

