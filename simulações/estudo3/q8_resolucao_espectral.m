% =========================================================
% Estudo Dirigido 3 – Questão 8
% Influência do número de amostras na resolução espectral
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Parâmetros
f8   = 0.1;
NFFT = 512;         % zero-padding comum para mesma escala de frequência
N_curto  = 32;
N_longo  = 256;

%% Sinais
n_curto = 0:N_curto-1;
n_longo = 0:N_longo-1;
x_curto = sin(2*pi*f8*n_curto);
x_longo = sin(2*pi*f8*n_longo);

%% FFT com zero-padding
X_curto = fft(x_curto, NFFT);
X_longo = fft(x_longo, NFFT);
fr8     = (0:NFFT-1) / NFFT;

%% Figura única com subplots
figure('Name','Q8 – Resolução espectral','NumberTitle','off');
set(gcf, 'Position', [100 100 1300 780]);

%% Subplot 1 – Sinal curto no tempo
subplot(2,3,1);
stem(n_curto, x_curto, 'filled', 'b');
grid on;
title(sprintf('Q8 – Sinal curto: N = %d amostras', N_curto));
xlabel('n'); ylabel('x[n]');

%% Subplot 2 – Espectro sinal curto
subplot(2,3,2);
plot(fr8(1:NFFT/2), abs(X_curto(1:NFFT/2)), 'b', 'LineWidth', 1.5);
grid on;
title(sprintf('Q8 – Espectro N=%d: baixa resolução (Δf = %.3f)', N_curto, 1/N_curto));
xlabel('Frequência normalizada'); ylabel('|X[k]|');

%% Subplot 3 – Sinal longo no tempo
subplot(2,3,4);
plot(n_longo(1:80), x_longo(1:80), 'r');
grid on;
title(sprintf('Q8 – Sinal longo: N = %d amostras (80 mostradas)', N_longo));
xlabel('n'); ylabel('x[n]');

%% Subplot 4 – Espectro sinal longo
subplot(2,3,5);
plot(fr8(1:NFFT/2), abs(X_longo(1:NFFT/2)), 'r', 'LineWidth', 1.5);
grid on;
title(sprintf('Q8 – Espectro N=%d: alta resolução (Δf = %.4f)', N_longo, 1/N_longo));
xlabel('Frequência normalizada'); ylabel('|X[k]|');

%% Subplot 5 – Comparação sobreposta
subplot(2,3,[3 6]);
plot(fr8(1:NFFT/2), abs(X_curto(1:NFFT/2)), 'b', 'LineWidth', 1.5); hold on;
plot(fr8(1:NFFT/2), abs(X_longo(1:NFFT/2)), 'r', 'LineWidth', 1.5); hold off;
grid on;
legend(sprintf('N = %d (Δf = %.3f)', N_curto, 1/N_curto), ...
       sprintf('N = %d (Δf = %.4f)', N_longo, 1/N_longo));
title('Q8 – Resolução espectral: maior N → pico mais estreito');
xlabel('Frequência normalizada'); ylabel('|X[k]|');
