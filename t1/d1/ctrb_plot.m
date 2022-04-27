function ctrb_plot(u1, u2, sim_out, xf, fig_name)
    x1      = sim_out.x1;
    x2      = sim_out.x2;
    x1dot   = sim_out.x1dot;
    x2dot   = sim_out.x2dot;
    t       = sim_out.tout;

    fig = figure('visible','off');
    set(fig, 'Position',  [0, 0, 800, 600]);
    
    subplot(2, 2, 1);
    plot(t, x1, 'b', t, x2, 'r--');
    xlim([0, t(end)]);
    ylim([0, 1.2 * max([xf(1), xf(3), max(x1), max(x2)])]);
    title('Curva de controle de posição');
    legend('$x_1$', '$x_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');
    
    subplot(2, 2, 2);
    plot(t, x1dot, 'b', t, x2dot, 'r--');
    xlim([0, t(end)]);
    ylim([0, 1.2 * max([xf(2), xf(4), max(x1dot), max(x2dot)])]);
    title('Curva de controle de velocidade');
    legend('$\dot{x}_1$', '$\dot{x}_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
    
    subplot(2, 1, 2);
    plot(t, u1(:, 2), 'b', t, u2(:, 2), 'r--');
    title('Esforço de controle');
    legend('$u_1$', '$u_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
    
    if not(isfolder('outputs'))
       mkdir('outputs/')
    end
    saveas(fig,['outputs/',fig_name]);
    close(fig);

end

