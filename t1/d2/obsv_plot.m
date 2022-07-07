function obsv_plot(sim_out, u1, u2, x0, result_type)
    %% Preparando o ambiente para criar os plots
    t  = sim_out.t ;    
    y  = sim_out.y ;
    yl = sim_out.yl;
    yf = sim_out.yf;
    x0e = sim_out.x0;
    error_x0e = x0e - x0.';
    
    folder = sprintf(['outputs/x0 = [%.2f %.2f %.2f %.2f]/', result_type], ...
        x0(1), x0(2), x0(3), x0(4));
    if not(isfolder(folder))
       mkdir(folder)
    end

    %% Resposta do sistema
    fig = figure('visible','off');
    set(fig, 'Position',  [0, 0, 800, 600]);
    
    subplot(3, 1, 1);
    plot(t, y(:, 1), t, y(:, 2));
    ylabel('Posição (m)')
    xlabel('Tempo (s)')
    title('Resposta completa do sistema');
    legend('$y_{1}$', '$y_{2}$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

    subplot(3, 1, 2);
    plot(t, yf(:, 1), t, yf(:, 2));
    ylabel('Posição (m)')
    xlabel('Tempo (s)')
    title('Resposta forçada do sistema');
    legend('$y_{f1}$', '$y_{f2}$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

    subplot(3, 1, 3);
    plot(t, yl(:, 1), t, yl(:, 2));
    ylabel('Posição (m)')
    xlabel('Tempo (s)')
    title('Resposta livre do sistema');
    legend('$y_{l1}$', '$y_{l2}$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');
    
    saveas(fig,[folder, '/system_output.pdf']);
    close(fig)

    %% Entrada aplicada

    fig = figure('visible','off');
    set(fig, 'Position',  [0, 0, 800, 600]);
    
    plot(t, u1(:, 2), t, u2(:, 2));
    title('Entrada aplicada ao sistema');
    ylabel('Força de controle (N)')
    xlabel('Tempo (s)')
    legend('$u_{1}$', '$u_{2}$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

    saveas(fig,[folder, '/system_input.pdf']);
    close(fig)

    %% Estimativa do estado inicial

    fig = figure('visible','off');
    set(fig, 'Position',  [0, 0, 800, 600]);
    
    subplot(2, 2, 1)
    plot(t, error_x0e(:, 1), 'Color', [0 0.4470 0.7410]);
    ylabel('Erro de posição (m)')
    xlabel('Tempo (s)')
    title('Erro na estimativa de x_1(0)');
    legend('${x_1}(0) - \overline{x}_1(0)$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

    subplot(2, 2, 2)
    plot(t, error_x0e(:, 2), 'Color', [0.8500 0.3250 0.0980]);
    ylabel('Erro de velocidade (m/s)')
    xlabel('Tempo (s)')
    title('Erro na estimativa de x`_1(0)');
    legend('${\dot{x}_1}(0) - \overline{\dot{x}}_1(0)$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

    subplot(2, 2, 3)
    plot(t, error_x0e(:, 3), 'Color', [0.9290 0.6940 0.1250]);
    ylabel('Erro de posição (m)')
    xlabel('Tempo (s)')
    title('Erro na estimativa de x_2(0)');
    legend('${x_2}(0) - \overline{x}_2(0)$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');


    subplot(2, 2, 4)
    plot(t, error_x0e(:, 4), 'Color', [0.4940 0.1840 0.5560]);
    ylabel('Erro de velocidade (m/s)')
    xlabel('Tempo (s)')
    title('Erro na estimativa de x`_2(0)');
    legend('${\dot{x}_2}(0) - \overline{\dot{x}}_2(0)$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');
    
    filename = sprintf(['/x0_estimative %.2f %.2f %.2f %.2f.pdf'], ...
        x0(1), x0(2), x0(3), x0(4));
    saveas(fig,[folder, filename]);
    close(fig)
    
end

