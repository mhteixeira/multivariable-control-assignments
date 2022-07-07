function ctrb_plot(u1, u2, sim_out, xf, fig_name)
    x1      = sim_out.x1;
    x2      = sim_out.x2;
    x1dot   = sim_out.x1dot;
    x2dot   = sim_out.x2dot;
    t       = sim_out.tout;

    folder = sprintf(['outputs/xf = [%.2f %.2f %.2f %.2f]'], ...
        xf(1), xf(2), xf(3), xf(4));
    if not(isfolder(folder))
       mkdir(folder)
    end

    fig = figure('visible','off');
    set(fig, 'Position',  [0, 0, 800, 600]);
    
    subplot(2, 2, 1);
    plot(t, x1, 'Color', [0 0.4470 0.7410]);
    ylabel('Posição (m)');
    xlabel('Tempo (s)');
    xlim([0, t(end)]);
    ylim([1.2 * min([xf(1), xf(3), min(x1), min(x2)]), ...
        1.2 * max([xf(1), xf(3), max(x1), max(x2)])]);
    title('Curva de controle de x_1');
    legend('$x_1$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
    
    subplot(2, 2, 2);
    plot(t, x2, 'Color', [0.8500 0.3250 0.0980]);
    ylabel('Posição (m)');
    xlabel('Tempo (s)');
    xlim([0, t(end)]);
    ylim([1.2 * min([xf(1), xf(3), min(x1), min(x2)]), ...
        1.2 * max([xf(1), xf(3), max(x1), max(x2)])]);
    title('Curva de controle de x_2');
    legend('$x_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
    

    subplot(2, 2, 3);
    plot(t, x1dot,  t, x2dot);
    ylabel('Velocidade (m/s)');
    xlabel('Tempo (s)');
    xlim([0, t(end)]);
    ylim([1.2 * min([xf(2), xf(4), min(x1dot), min(x2dot)]), ...
        1.2 * max([xf(2), xf(4), max(x1dot), max(x2dot)])]);
    title('Curva de controle de velocidade');
    legend('$\dot{x}_1$', '$\dot{x}_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
    
    subplot(2, 2, 4);
    plot(t, u1(:, 2), t, u2(:, 2));
    title('Esforço de controle');
    ylabel('Força de controle (N)');
    xlabel('Tempo (s)');
    legend('$u_1$', '$u_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
    
    saveas(fig,[folder, '/', fig_name]);
    close(fig);

end

