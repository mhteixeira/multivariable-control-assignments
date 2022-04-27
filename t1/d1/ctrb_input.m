function [u1, u2] = ctrb_input(sim_step, Tf, A, B, x0, xf, Wc)
    tsim = (0:sim_step:Tf);
    n = Tf/sim_step+1;
    u1 = zeros(n, 2); u2 = zeros(n, 2);
    for i = 1:n
        t = tsim(i);
        u_i = -B.'*expm((Tf-t)*A.')/(Wc)*(expm(Tf*A)*x0-xf);
        u1(i, :) = [t u_i(1)];
        u2(i, :) = [t u_i(2)];
    end
end

