% =========================================================
% Estudo Dirigido 3 – Questão 2
% Soma de duas senoides e análise espectral
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Parâmetros
N  = 128;
f1 = 0.1;
f2 = 0.3;

%% Geração dos sinais
n   = 0:N-1;
x1  = sin(2*pi*f1*n);
x2  = sin(2*pi*f2*n);
x   = x1 + x2;         % sinal composto

%% FFT
X     = fft(x);
mag   = abs(X) / N;
freqs = (0:N-1) / N;

%% Figura única com subplots
figure('Name','Q2 – Soma de senoides e FFT','NumberTitle','off');
set(gcf, 'Position', [100 100 1000 420]);

%% Subplot 1 – Domínio do tempo
subplot(1,2,1);
plot(n, x, 'b');
grid on;
title('Q2 – Soma de duas senoides: f_1 = 0,1 e f_2 = 0,3');
xlabel('n'); ylabel('x[n]');

%% Subplot 2 – Espectro
subplot(1,2,2);
stem(freqs(1:N/2), mag(1:N/2)*2, 'filled', 'r');
grid on;
title('Q2 – Espectro FFT: dois picos distintos identificados');
xlabel('Frequência normalizada'); ylabel('|X[k]| / N');
