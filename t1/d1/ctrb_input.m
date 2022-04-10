% function u = ctrb_input(t, A, B, x0, xf, Wc, Tf)
%     u = -B.'*exp(Tf-t);
function u = ctrb_input(t)
    global A  B x0 xf Wc Tf;
    u = -B.'*expm((Tf-t)*A.')*inv(Wc)*(expm(Tf*A)*x0-xf);
end

