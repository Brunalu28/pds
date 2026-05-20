% =========================================================
% Estudo Dirigido 3 – Questão 4
% Janelamento e vazamento espectral
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Parâmetros
f4   = 0.12;
N4   = 64;
NFFT = 512;     % zero-padding para visualização suave

%% Sinal e janela
n4   = 0:N4-1;
x4   = sin(2*pi*f4*n4);
w    = hamming(N4)';     % janela de Hamming (linha)
x4_w = x4 .* w;

%% FFT com zero-padding
X4   = fft(x4,   NFFT);
X4_w = fft(x4_w, NFFT);
fr4  = (0:NFFT-1) / NFFT;

%% Figura única (Deixando o tamanho dinâmico do servidor para evitar cortes)
figure(1);

%% Subplot 1 – Sinal sem janela no tempo
% Posição manual: [Esquerda, Baixo, Largura, Altura]
subplot('Position', [0.08, 0.56, 0.38, 0.36]);
stem(n4, x4, 'filled', 'b');
grid on;
title('Sinal sem janelamento');
xlabel('n'); ylabel('x[n]');

%% Subplot 2 – Espectro sem janela (dB)
subplot('Position', [0.56, 0.56, 0.38, 0.36]);
plot(fr4(1:NFFT/2), 20*log10(abs(X4(1:NFFT/2))/N4 + 1e-10), 'b');
grid on;
title('Espectro (Retangular) em dB: Vazamento');
xlabel('Freq. normalizada'); ylabel('Magnitude (dB)');
ylim([-80 10]);

%% Subplot 3 – Sinal com janela Hamming no tempo
subplot('Position', [0.08, 0.10, 0.38, 0.36]);
stem(n4, x4_w, 'filled', 'r');
grid on;
title('Sinal com janela de Hamming');
xlabel('n'); ylabel('x[n] \cdot w[n]');

%% Subplot 4 – Espectro com janela Hamming (dB)
subplot('Position', [0.56, 0.10, 0.38, 0.36]);
plot(fr4(1:NFFT/2), 20*log10(abs(X4_w(1:NFFT/2))/N4 + 1e-10), 'r');
grid on;
title('Espectro (Hamming) em dB: Lobulos Reduzidos');
xlabel('Freq. normalizada'); ylabel('Magnitude (dB)');
ylim([-80 10]);

%% Força o servidor a desenhar e consolidar as dimensões corretas
drawnow;