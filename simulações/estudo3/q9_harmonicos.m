% =========================================================
% Estudo Dirigido 3 – Questão 9
% Sinal com fundamental e harmônico – diagnóstico espectral
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Parâmetros
N9     = 512;
f_fund = 0.05;      % frequência fundamental
f_harm = 0.10;      % 2º harmônico (2 × f_fund)

%% Sinal
n9 = 0:N9-1;
x9 = sin(2*pi*f_fund*n9) + 0.5*sin(2*pi*f_harm*n9);

%% FFT
X9  = fft(x9);
mag9 = abs(X9) / N9 * 2;
fr9  = (0:N9-1) / N9;

%% Figura única com subplots
figure('Name','Q9 – Fundamental e harmônicos','NumberTitle','off');
set(gcf, 'Position', [100 100 1000 420]);

%% Subplot 1 – Domínio do tempo
subplot(1,2,1);
plot(n9(1:100), x9(1:100), 'b');
grid on;
title('Q9 – Sinal: fundamental + 2º harmônico (primeiras 100 amostras)');
xlabel('n'); ylabel('x[n]');

%% Subplot 2 – Espectro com anotações
subplot(1,2,2);
stem(fr9(1:N9/2), mag9(1:N9/2), 'filled', 'r');
grid on;
title('Q9 – Espectro FFT: fundamental e 2º harmônico identificados');
xlabel('Frequência normalizada'); ylabel('Magnitude');

% Anotações
[~, idx1] = max(mag9(1:N9/2));
[~, idx2] = max(mag9(idx1+1:N9/2));
idx2 = idx2 + idx1;

text(fr9(idx1) + 0.02, mag9(idx1), ...
     sprintf('Fundamental\nf = %.2f', fr9(idx1)), ...
     'Color', 'b', 'FontSize', 9);
text(fr9(idx2) + 0.02, mag9(idx2), ...
     sprintf('2º Harmônico\nf = %.2f', fr9(idx2)), ...
     'Color', [0 0.5 0], 'FontSize', 9);
