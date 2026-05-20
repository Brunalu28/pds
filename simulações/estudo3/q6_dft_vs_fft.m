% =========================================================
% Estudo Dirigido 3 – Questão 6
% DFT direta vs FFT: equivalência e custo computacional
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Sinal curto para comparação
x6 = [1 2 3 2 1];
N6 = length(x6);

%% DFT direta (definição matemática)
X6_dft = zeros(1, N6);
for k = 0:N6-1
    for n = 0:N6-1
        X6_dft(k+1) = X6_dft(k+1) + x6(n+1) * exp(-1j*2*pi*k*n/N6);
    end
end

%% FFT nativa do MATLAB
X6_fft = fft(x6);

%% Comparação numérica
fprintf('=== Comparação DFT direta vs FFT ===\n');
% Correção de compatibilidade para Octave/MATLAB antigo:
fprintf('Magnitude DFT direta: '); disp(round(abs(X6_dft) * 10000) / 10000);
fprintf('Magnitude FFT:        '); disp(round(abs(X6_fft) * 10000) / 10000);
fprintf('Erro máximo: %.2e\n\n', max(abs(X6_dft - X6_fft)));

%% Custo computacional: N grande
N_big = 1024;
x_big = randn(1, N_big);

% DFT direta (apenas 10 coeficientes, para não demorar demais)
tic;
X_dft_parcial = zeros(1, 10);
for k = 0:9
    for n = 0:N_big-1
        X_dft_parcial(k+1) = X_dft_parcial(k+1) + x_big(n+1)*exp(-1j*2*pi*k*n/N_big);
    end
end
t_dft = toc;

% FFT
tic;
for rep = 1:1000
    fft(x_big);
end
t_fft = toc / 1000;

fprintf('=== Custo computacional (N = %d) ===\n', N_big);
fprintf('DFT direta (10 coef.): %.2f ms\n', t_dft*1000);
fprintf('FFT:                   %.3f ms\n', t_fft*1000);
fprintf('FFT é ~%.0fx mais rápida\n\n', t_dft/t_fft);

%% Figura única com subplots
figure('Name','Q6 – DFT vs FFT','NumberTitle','off');

%% Subplot 1 – Comparação de magnitudes
subplot(1,2,1);
bar_data = [abs(X6_dft)', abs(X6_fft)'];
bar(0:N6-1, bar_data, 'grouped');
grid on;
legend('DFT direta', 'FFT (MATLAB)');
title('Q6 – Magnitude: DFT direta vs FFT (resultados idênticos)');
xlabel('k'); ylabel('|X[k]|');

%% Subplot 2 – Erro numérico
subplot(1,2,2);
bar(0:N6-1, abs(X6_dft - X6_fft), 'r');
grid on;
title('Q6 – Diferença numérica |DFT − FFT| ≈ 0');
xlabel('k'); ylabel('Erro');