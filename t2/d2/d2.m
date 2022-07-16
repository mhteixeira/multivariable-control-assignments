%% Enunciado do Desafio 2
%  

format short;
close all;
clear; clc;

%% Definição dos parâmetros do problema

M   = 1;
K_m   = 1;
Tf  = 20;
sim_step = 0.01;

x0 = [0; 0; 0; 0];

%% Definição do sistema a ser controlado
A   = [0 1 0 0; -K_m/M 0 K_m/M 0; 0 0 0 1; K_m/M 0 -K_m/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = [1 0 0 0; 0 0 1 0];
D   = [0 0; 0 0];

% Modelagem dos sinais de perturbação
omega = 0.5;
Ai  = [0 1 0; 0 0 1; 0 -omega^2 0];
Bi  = [0; 0; 1];
Ci  = [1 0 0];

% Confecção do sistema auxiliar
Ao  = [Ai zeros(3, 3); zeros(3, 3) Ai];
Bo  = [Bi zeros(3, 1); zeros(3, 1) Bi];
Co  = [Ci zeros(1, 3); zeros(1, 3) Ci];
Do  = zeros(2, 2);

% Confecção do sistema aumentado
At  = [A B*Co; zeros(6, 4) Ao];
Bt  = [B zeros(4, 2); zeros(6, 2) Bo];
Ct  = [C zeros(2, 6)];

%% Definição do controlador

[K, S, E] = lqr(At, Bt, 1e3*eye(10), eye(4));
Ft = -K;
[H, S, E] = lqr(At.', Ct.', 1e3*eye(10), eye(2));
Kt = H';