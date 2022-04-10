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
global A  B x0 xf Wc Tf;
%% Definição dos parâmetros do problema
M   = 1;
K   = 1;
Tf  = 1;

x0 = [0; 0; 0; 0];
xf = [1; 0; 2; 10];

%% Definição do sistema a ser controlado

A   = [0 1 0 0; -K/M 0 K/M 0; 0 0 0 1; K/M 0 -K/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = eye(4);
D   = [0 0; 0 0;0 0;0 0];

%% Cálculo do gramiano

Wc = ctrb_gramm(A, B, [0 Tf]);

%% Execução do diagrama do Simulink

simout = sim("crtb_model.slx", 'TimeOut', Tf);
u2  = simout.u2;
u1  = simout.u1;
x1  = simout.x1;
x2  = simout.x2;
x1dot  = simout.x1dot;
x2dot  = simout.x2dot;
t   = simout.tout;
 
%% Apresentação dos resultados

figure(1);
xlim([0, Tf]);
subplot(2, 2, 1);
plot(t, x1, 'b', t, x2, 'r');
title('Curva de controle de posição');
legend('$x_1$', '$x_2$','Interpreter','latex', 'FontSize',10);

subplot(2, 2, 2);
plot(t, x1dot, 'b', t, x2dot, 'r');
title('Curva de controle de velocidade');
legend('$\dot{x}_1$', '$\dot{x}_2$','Interpreter','latex', 'FontSize',10);

subplot(2, 1, 2);
plot(t, u1, 'b', t, u2, 'r');
title('Esforço de controle');
legend('$u_1$', '$u_2$','Interpreter','latex', 'FontSize',10);