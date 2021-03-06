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
Tf  = 50;
sim_step = 0.001;

x0 = [0; 0; 0; 0];
r = [1; 5];

%% Definição do sistema a ser controlado

A   = [0 1 0 0; -K_m/M 0 K_m/M 0; 0 0 0 1; K_m/M 0 -K_m/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = [1 0 0 0; 0 0 1 0];
D   = [0 0; 0 0];

%% Imposição de polos:

pF = [-5 -2 -5 -2];
pK = [-1 -2 -1 -2];
F = -place(A , B, pF);
K = place(A.',C.',pK)';

%% Simulação com Imposição de Polos via place:

sim_out = sim("comp_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

comp_plot(sim_out, r, 'place_result.pdf');

%% Controle LQR:

F = -lqr(A,B,eye(4),eye(2),0);
K = lqr(A.',C.',eye(4),eye(2),0)';

%% Simulação com controle LQR:

sim_out2 = sim("comp_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

comp_plot(sim_out2, r, 'lqr_result.pdf');

%% Imposição de polos de valor grande:

pF = [-5 -2 -5 -2];
pK = [-1 -2 -1 -2];
F = -place(A , B, pF);
K = place(A.',C.',pK*500)';


%% Simulação de imposição de polos com polos grandes:

sim_out3 = sim("comp_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

comp_plot(sim_out3, r, 'place2_result.pdf');

%% Rastreamento

Ar   = [0      1 0      0 0   0; 
        -K_m/M 0 K_m/M  0 1/M 0; 
        0      0 0      1 0   0;
        K_m/M  0 -K_m/M 0 0   1/M;
        0      0 0      0 0   0;
        0      0 0      0 0   0];
    
Br   = [0   0   0   0; 
        1/M 0   0   0; 
        0   0   0   0; 
        0   1/M 0   0;
        0   0   1   0;
        0   0   0   1];

Cr   = [1 0 0 0 0 0; 
        0 0 1 0 0 0];

Dr   = [0 0; 0 0; 0 0; 0 0];

Amr = [0 0; 0 0];
Bmr = [1 0; 0 1];
Cmr = [1 0; 0 1];
Dmr = [0 0; 0 0];

x0r = [x0; 0; 0];

Fr = -lqr(Ar,Br,eye(6),eye(4),0);
Kr = lqr(Ar.',Cr.',eye(6),eye(2),0)';

%% Simulação de sistema aumentado para rastreamento:

sim_out4 = sim("rstr_model.slx", ...
    'StartTime', '0', ...
    'StopTime', num2str(Tf), ...
    'FixedStep', num2str(sim_step));

comp_plot(sim_out4, r, 'rstr_result.pdf');
