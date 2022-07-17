%% Enunciado do Desafio 2
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
Tf  = 40;
sim_step = 0.01;
r = [1;1];
x0 = [0; 0; 0; 0];

%% Definição do sistema a ser controlado
A   = [0 1 0 0; -K_m/M 0 K_m/M 0; 0 0 0 1; K_m/M 0 -K_m/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = [1 0 0 0; 0 0 1 0];
D   = [0 0; 0 0];

% Modelagem dos sinais de perturbação
omega = 2;
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

%% Imposição de polos

pF = [-1 -2 -3 -4 -1 -2 -3 -4 -5 -6];
pK = [-1 -2 -3 -4 -1 -2 -3 -4 -5 -6];
Ft = -place(At , Bt, pF);
Kt = place(At.',Ct.',pK)';

%% Simulação com Imposição de Polos via place:

sim_out = sim("d2_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

d2_plot(sim_out, r, 'place_result.pdf');

%% Definição do controlador por LQR

[K, S, E] = lqr(At, Bt, 3e2*eye(10), eye(4));
Ft = -K;
[H, S, E] = lqr(At.', Ct.', 3e2*eye(10), eye(2));
Kt = H';

%% Simulação com Imposição de Polos via LQR:

sim_out2 = sim("d2_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

d2_plot(sim_out2, r, 'lqr_result.pdf');

