function comp_plot(sim_out, r, fig_name)
    u1      = sim_out.u1;
    u2      = sim_out.u2;
    x1      = sim_out.x1;
    x2      = sim_out.x2;
    x1dot   = sim_out.x1dot;
    x2dot   = sim_out.x2dot;
    n1     = sim_out.n1;
    n2     = sim_out.n1;
    y1      = sim_out.y1;
    y2      = sim_out.y2;
    t       = sim_out.tout;
    xf      = [r(1);0;r(2);0];

    folder = sprintf(['outputs/r = [%.2f %.2f]'], ...
        r(1), r(2));
    if not(isfolder(folder))
       mkdir(folder)
    end

    fig = figure('visible','off');
    set(fig, 'Position',  [0, 0, 800, 600]);
    
    subplot(3, 2, 3);
    p=plot(t, y1, t, y2);
    ylabel('Posição (m)');
    xlabel('Tempo (s)');
    xlim([0, t(end)]);
    ylim([1.2 * min([xf(1), xf(3), min(y1), min(y2)])-0.1, ...
        1.2 * max([xf(1), xf(3), max(y1), max(y2)])]+0.1);
    r1=yline(r(1),'--');
    r1.Color = '#9999FF';
    r2=yline(r(2),'--');
    r2.Color = '#FF9999';
    title('Curva de controle de posição');
    legend('$y_1$', '$y_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');
%     datatip(p,'DataIndex',length(x1))
%     datatip(p,'DataIndex',length(x2))
    
    subplot(3, 1, 1);
    p=plot(t, n1, t, n2);
    ylabel('Ruído (m)');
    xlabel('Tempo (s)');
    r1=yline(r(1),'--');
    r1.Color = '#9999FF';
    r2=yline(r(2),'--');
    r2.Color = '#FF9999';
    xlim([0, t(end)]);
    ylim([1.2 * min([xf(1), xf(3), min(n1), min(n2)])-0.1, ...
        1.2 * max([xf(1), xf(3), max(n1), max(n2)])]+0.1);
    title('Disturbio incluído no sensor');
    legend('$n_1$', '$n_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');
    
    subplot(3, 2, 4);
    p=plot(t, x1dot,  t, x2dot);
    ylabel('Velocidade (m/s^2)');
    xlabel('Tempo (s)');
    xlim([0, t(end)]);
    ylim([1.2 * min([xf(2), xf(4), min(x1dot), min(x2dot)])-0.1, ...
        1.2 * max([xf(2), xf(4), max(x1dot), max(x2dot)])]+0.1);
    title('Curva de controle de velocidade');
    legend('$\dot{x}_1$', '$\dot{x}_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
%     datatip(p,'DataIndex',length(x1dot))
%     datatip(p,'DataIndex',length(x2dot))
    
    subplot(3, 1, 3);
    p=plot(t, u1, t, u2);
    title('Esforço de controle');
    ylabel('Força de controle (N)');
    xlabel('Tempo (s)');
    legend('$u_1$', '$u_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');
%     datatip(p,'DataIndex',length(u1(:, 2)))
%     datatip(p,'DataIndex',length(u2(:, 2)))
    
    saveas(fig,[folder, '/', fig_name]);
    close(fig);

end

