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
Tf  = 1;

x0 = [0 0 0 0];
xf = [1 0 1 0];

%% Definição do sistema a ser controlado

A   = [0 1 0 0; -K/M 0 -K/M 0; 0 0 0 1; -K/M 0 -K/M 0];
B   = [0 0; 1/M 0; 0 0; 0 1/M];
C   = [1 0 0 0; 0 0 1 0];
D   = [0 0; 0 0];

%% Cálculo do gramiano

Wc = ctrb_gramm(A, B, [0 Tf]);

%% Execução do diagrama do Simulink

%% Apresentação dos resultados

