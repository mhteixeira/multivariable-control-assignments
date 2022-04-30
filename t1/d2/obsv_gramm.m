function Wo = obsv_gramm(A, C, time_interval)
    dWo = @(t) (expm(t*A.')*C.')*C*expm(t*A);
    Wo = integral(dWo, time_interval(1), time_interval(2), 'ArrayValued', true);
end