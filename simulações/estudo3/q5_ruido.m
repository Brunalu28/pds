% =========================================================
% Estudo Dirigido 3 – Questão 5
% Análise espectral na presença de ruído aditivo
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

rng(42);    % semente para reprodutibilidade

%% Parâmetros
f5 = 0.15;
N5 = 256;
n5 = 0:N5-1;

%% Sinais
sinal = sin(2*pi*f5*n5);
ruido = 1.5 * randn(1, N5);
x5    = sinal + ruido;

%% FFT
X_sinal = fft(sinal);
X_ruido = fft(x5);
fr5     = (0:N5-1) / N5;

%% Figura única (Deixando o tamanho nativo do servidor para eliminar os cortes)
figure(1);

%% Subplot 1 – Senoide pura no tempo
% Coordenadas manuais: [Esquerda, Baixo, Largo, Alto]
subplot('Position', [0.08, 0.56, 0.38, 0.36]);
plot(n5, sinal, 'b', 'LineWidth', 1.2);
grid on;
title('Senoide Pura (f = 0,15)');
xlabel('n'); ylabel('Amplitude');

%% Subplot 2 – Sinal com ruído no tempo
subplot('Position', [0.56, 0.56, 0.38, 0.36]);
plot(n5, x5, 'Color', [0.7 0 0]);
grid on;
title('Senoide + Ruido (SNR Baixo)');
xlabel('n'); ylabel('Amplitude');

%% Subplot 3 – Espectro da senoide pura
subplot('Position', [0.08, 0.10, 0.38, 0.36]);
stem(fr5(1:N5/2), abs(X_sinal(1:N5/2))/N5*2, 'filled', 'b');
grid on;
title('Espectro Puro: Pico em f = 0,15');
xlabel('Freq. normalizada'); ylabel('Magnitude');

%% Subplot 4 – Espectro com ruído
subplot('Position', [0.56, 0.10, 0.38, 0.36]);
plot(fr5(1:N5/2), abs(X_ruido(1:N5/2))/N5*2, 'Color', [0.7 0 0], 'LineWidth', 1.2);
grid on;
title('Espectro com Ruido: Pico Visivel');
xlabel('Freq. normalizada'); ylabel('Magnitude');

%% Assegura que o motor gráfico monte a imagem completa sem perdas nas bordas
drawnow;