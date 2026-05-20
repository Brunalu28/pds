% =========================================================
% Estudo Dirigido 3 – Questão 10
% Análise espectral de vibração mecânica simulada
% Máquina a 25 Hz (1500 RPM), fs = 1000 Hz
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

rng(7);

fs = 1000;
T  = 2;

t = 0:1/fs:T-1/fs;
f_rot = 25;

x10 = sin(2*pi*f_rot*t) + 0.4*randn(size(t));

X10 = fft(x10);
f = (0:length(X10)-1)*(fs/length(X10));

figure('Name','Q10');

subplot(2,1,1)
plot(t, x10);
grid on;
title('Sinal de vibração');

subplot(2,1,2)
plot(f, abs(X10));
grid on;
title('Espectro de frequência');
xlim([0 100]);