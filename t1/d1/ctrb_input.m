function [u1, u2] = ctrb_input(sim_step, Tf, A, B, x0, xf, Wc)
    u = [];
    tsim = (0:sim_step:Tf);
    for i = 1:(Tf/sim_step+1)
        t = tsim(i);
        u = [u -B.'*expm((Tf-t)*A.')*inv(Wc)*(expm(Tf*A)*x0-xf)];
    end
    u1 = [tsim; u(1, :)]'; 
    u2 = [tsim; u(2, :)]';
end

