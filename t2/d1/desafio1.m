%% Enunciado do Desafio 1
%  
% # Projetar um compensador de estabilização usando imposição de polos.
% # Implementar um diagrama do Simulink que leve o sistema de y_0 a r.
% # Projetar um compensador de estabilização usando LQR.
% # Testar o projeto de imposição de polos usando polos grandes.
% # Testar o compensador projetado com LQR em um sistema de ordem maior.
% # Discutir os resultados obtidos.

format short;
close all;
clear; clc;

%% Definição dos parâmetros do problema

M   = 1;
K_m   = 1;
Tf  = 10;
sim_step = 0.01;

x0 = [0; 0; 0; 0];
r = [1; 1];

%% Definição do sistema a ser controlado

A   = [0 1 0 0; -K_m/M 0 K_m/M 0; 0 0 0 1; K_m/M 0 -K_m/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = [1 0 0 0; 0 0 1 0];
D   = [0 0; 0 0];

%% Imposição de polos:
pF = [-4 -2 -4 -2];
pK = [-1 -2 -1 -2];
F = -place(A , B, pF);
K = place(A.',C.',pK)';


%% Simulação:

sim_out = sim("comp_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

comp_plot(sim_out, r, 'initial_result.pdf');

%% Controle LQR:

F = -lqr(A,B,eye(4),eye(2),0);
K = lqr(A.',C.',eye(4),eye(2),0)';
