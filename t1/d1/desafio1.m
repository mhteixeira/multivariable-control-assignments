%% Enunciado do Desafio 1
%  
% # Calcular o Gramiano de Controlabilidade do sistema massa-mola proposto
% # Implementar um diagrama do Simulink que leve o sistema de x_0 a um x_f
% # Simular o sistema usando o diagrama e apresentar resultados
% # Alterar as massas e repetir a simulação
% # Discutir os resultados obtidos

format short;
close all;
clear; clc;
global A  B x0 xf Wc Tf sim_step;

%% Definição dos parâmetros do problema
M   = 1;
K   = 1;
Tf  = 2;
sim_step = 0.01;

x0 = [0; 0; 0; 0];
xf = [1; 0; 1; 0];

%% Definição do sistema a ser controlado

A   = [0 1 0 0; -K/M 0 K/M 0; 0 0 0 1; K/M 0 -K/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = eye(4);
D   = [0 0; 0 0;0 0;0 0];

%% Cálculo do gramiano

Wc = ctrb_gramm(A, B, [0 Tf]);

%% Esforço de controle em malha aberta

[u1, u2] = ctrb_input(sim_step, Tf, A, B, x0, xf, Wc);

%% Execução do diagrama do Simulink

sim_out = sim("crtb_model.slx", 'StartTime', '0', 'StopTime', num2str(Tf), 'FixedStep', num2str(sim_step));
x1      = sim_out.x1;
x2      = sim_out.x2;
x1dot   = sim_out.x1dot;
x2dot   = sim_out.x2dot;
t       = sim_out.tout;
 
%% Apresentação dos resultados ideais

fig = figure('visible','off');
set(fig, 'Position',  [0, 0, 800, 600])

xlim([0, Tf]);
subplot(2, 2, 1);
plot(t, x1, 'b', t, x2, 'r--');
title('Curva de controle de posição');
legend('$x_1$', '$x_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

subplot(2, 2, 2);
plot(t, x1dot, 'b', t, x2dot, 'r--');
title('Curva de controle de velocidade');
legend('$\dot{x}_1$', '$\dot{x}_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');

subplot(2, 1, 2);
plot(t, u1(:, 2), 'b', t, u2(:, 2), 'r--');
title('Esforço de controle');
legend('$u_1$', '$u_2$','Interpreter','latex', 'FontSize', 10, 'Location', 'Best');

saveas(fig,'outputs/initial_result.pdf')
close(fig)

%% Mudança de parâmetros para alterar a massa 

M   = M*1.1;
A   = [0 1 0 0; -K/M 0 K/M 0; 0 0 0 1; K/M 0 -K/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];

%% Execução do diagrama do Simulink p/ massa alterada

sim_out = sim("crtb_model.slx", 'StartTime', '0', 'StopTime', num2str(Tf), 'FixedStep', num2str(sim_step));
x1      = sim_out.x1;
x2      = sim_out.x2;
x1dot   = sim_out.x1dot;
x2dot   = sim_out.x2dot;
t       = sim_out.tout;

%% Apresentação dos resultados p/ massa alterada

fig = figure('visible','off');
set(fig, 'Position',  [0, 0, 800, 600])

xlim([0, Tf]);
subplot(2, 2, 1);
plot(t, x1, 'b', t, x2, 'r--');
title('Curva de controle de posição');
legend('$x_1$', '$x_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

subplot(2, 2, 2);
plot(t, x1dot, 'b', t, x2dot, 'r--');
title('Curva de controle de velocidade');
legend('$\dot{x}_1$', '$\dot{x}_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

subplot(2, 1, 2);
plot(t, u1(:, 2), 'b', t, u2(:, 2), 'r--');
title('Esforço de controle');
legend('$u_1$', '$u_2$','Interpreter','latex', 'FontSize',10, 'Location', 'Best');

saveas(fig,'outputs/altered_mass_result.pdf')
close(fig)