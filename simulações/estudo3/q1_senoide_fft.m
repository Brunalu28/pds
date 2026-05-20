% =========================================================
% Estudo Dirigido 3 – Questão 1
% Senoide discreta e espectro via FFT
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Parâmetros
N  = 128;       % número de amostras
f0 = 0.1;       % frequência normalizada

%% Geração do sinal
n  = 0:N-1;
x  = sin(2*pi*f0*n);

%% FFT
X     = fft(x);
mag   = abs(X) / N;                    % magnitude normalizada
freqs = (0:N-1) / N;                   % eixo de frequência normalizada [0, 1)

%% Figura única com subplots
figure('Name','Q1 – Senoide discreta e FFT','NumberTitle','off');
set(gcf, 'Position', [100 100 1000 420]);

%% Subplot 1 – Domínio do tempo
subplot(1,2,1);
stem(n(1:40), x(1:40), 'filled', 'b');
grid on;
title('Q1 – Senoide discreta f_0 = 0,1 (primeiras 40 amostras)');
xlabel('n'); ylabel('x[n]');

%% Subplot 2 – Espectro (metade positiva)
subplot(1,2,2);
stem(freqs(1:N/2), mag(1:N/2)*2, 'filled', 'r');
grid on;
title('Q1 – Espectro FFT: frequência dominante em f = 0,1');
xlabel('Frequência normalizada'); ylabel('|X[k]| / N');
