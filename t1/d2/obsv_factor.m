function s = obsv_factor(in)
    global A C;
    t = in(1);
    yl = in(2:3);
    s = expm(t*A.')*C.'*yl;
end

