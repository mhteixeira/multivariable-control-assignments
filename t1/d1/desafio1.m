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
D   = [0 0; 0 0; 0 0; 0 0];

%% Cálculo do gramiano

Wc = ctrb_gramm(A, B, [0 Tf]);

%% Esforço de controle em malha aberta

[u1, u2] = ctrb_input(sim_step, Tf, A, B, x0, xf, Wc);

%% Execução do diagrama do Simulink

sim_out = sim("crtb_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

%% Apresentação dos resultados ideais

ctrb_plot(u1, u2, sim_out, xf, 'initial_result.pdf');

%% Alterando a massa

M   = M * 1.1;
A   = [0 1 0 0; -K/M 0 K/M 0; 0 0 0 1; K/M 0 -K/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];

%% Execução do diagrama do Simulink p/ massa alterada

sim_out2 = sim("crtb_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

%% Apresentação dos resultados p/ massa alterada

ctrb_plot(u1, u2, sim_out2, xf, 'altered_mass_result.pdf');
