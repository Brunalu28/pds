% =========================================================
% Estudo Dirigido 3 – Questão 3
% Aliasing por redução da taxa de amostragem
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Parâmetros
f_sig  = 0.4;       % frequência normalizada original
N_orig = 256;
fator  = 4;         % fator de sub-amostragem

%% Sinal original
n_orig  = 0:N_orig-1;
x_orig  = sin(2*pi*f_sig*n_orig);

%% Sub-amostragem (1 de cada 'fator' amostras)
x_ds = x_orig(1:fator:end);
N_ds = length(x_ds);

%% FFT de ambos
X_orig = fft(x_orig);
X_ds   = fft(x_ds);
fr_orig = (0:N_orig-1) / N_orig;
fr_ds   = (0:N_ds-1)   / N_ds;

%% Figura única (Deixando o tamanho nativo do servidor para evitar cortes nas bordas)
figure(1);

%% Subplot 1 – Sinal original no tempo
% Coordenadas manuais: [Esquerda, Baixo, Largura, Altura]
subplot('Position', [0.08, 0.56, 0.38, 0.36]);
plot(n_orig(1:80), x_orig(1:80), 'b', 'LineWidth', 1.2);
grid on;
title('Sinal Original (f = 0,4)');
xlabel('n'); ylabel('x[n]');

%% Subplot 2 – Espectro original
subplot('Position', [0.56, 0.56, 0.38, 0.36]);
stem(fr_orig(1:N_orig/2), abs(X_orig(1:N_orig/2))/N_orig*2, 'filled', 'b');
grid on;
title('Espectro Original: Pico em f = 0,4');
xlabel('Freq. normalizada'); ylabel('Magnitude');

%% Subplot 3 – Sinal sub-amostrado no tempo
subplot('Position', [0.08, 0.10, 0.38, 0.36]);
stem(0:N_ds-1, x_ds, 'filled', 'r');
grid on;
title(sprintf('Sinal Sub-amostrado (Fator %d)', fator));
xlabel('n'); ylabel('x_{ds}[n]');

%% Subplot 4 – Espectro com aliasing
subplot('Position', [0.56, 0.10, 0.38, 0.36]);
stem(fr_ds(1:N_ds/2), abs(X_ds(1:N_ds/2))/N_ds*2, 'filled', 'r');
grid on;
title('Aliasing: Pico deslocado para f = 0,1');
xlabel('Freq. normalizada'); ylabel('Magnitude');

%% Força o motor gráfico do servidor a consolidar as alterações sem truncar
drawnow;