bias = 2*((2*pi)/360);

alpha = bias*[1 -1 1 -1 1 -1];
B = get_B(alpha);

thresh = 1
for i=1:2
    for j=1:12
        val = B(i,j);
        if(abs(val) < thresh)
            B(i,j) = 0;
        end
    end
end
[U,S,V] = svd(B);
wrench = [0 1 9.81*4.95 0 0 0]';

omega_sq = pinv(B)*wrench;
omega = sqrt(omega_sq)
