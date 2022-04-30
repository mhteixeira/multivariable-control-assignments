%% Enunciado do Desafio 2
%  
% # Calcular o Gramiano de Observabilidade do sistema massa-mola proposto
% # Implementar um diagrama do Simulink que estime o estado inicial com a
% saída livre do sistema (diferença entre a resposta completa e a forçada)
% # Simular o sistema usando o diagrama e apresentar resultados

format short;
clear; clc;
close all;


%% Definição dos parâmetros do problema

M   = 2;
K   = 1;
Tf  = 1;
sim_step = 0.01;

x0   = [1; 0; 2; 0];
zero = [0; 0; 0; 0];

%% Definição do sistema a ser observado 

A   = [0 1 0 0; -K/M 0 K/M 0; 0 0 0 1; K/M 0 -K/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = [1 0 0 0; 0 0 1 0];
D   = [0 0; 0 0];

%% Cálculo do gramiano

Wo = obsv_gramm(A, C, [0 Tf]);

%% Definição arbitrária das entradas

tsim = (0:sim_step:Tf).';
u1 = [tsim 10*cos(10*tsim)];
u2 = [tsim 10*cos(10*tsim)];

%% Execução do diagrama do Simulink

sim_out = sim("obsv_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

%% Estimativa do valor de x0

t = sim_out.t;
y = sim_out.y;
yl = sim_out.yl;
yf = sim_out.yf;

figure(1)
plot(t, y)
figure(2)
plot(t, yl)
figure(3)
plot(t, yf)

x0e = obsv_estimate_x0(yl, A, C, Tf, Wo);
