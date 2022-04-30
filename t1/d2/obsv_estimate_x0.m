function x0 = obsv_estimate_x0(yl, A, C, Tf, Wo)
    dx0 = @(t) expm(t*A.')*C.'*ybt(yl, t);
    x0 = Wo\integral(dx0, 0, Tf, 'ArrayValued', true);

    function y = ybt(yl, t)
        s=1:size(yl, 1);
        [m, pos] = min(abs(s-t));
        y=yl(pos, :).';
    end
end