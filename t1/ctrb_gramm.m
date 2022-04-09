function Wc = ctrb_gramm(A, B, time_interval)
    dWc = @(t) (expm(t*A)*B)*B.'*expm(t*A.');
    Wc = integral(dWc, time_interval(1), time_interval(2), 'ArrayValued', true);
end

