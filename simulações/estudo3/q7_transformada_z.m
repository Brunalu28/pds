% =========================================================
% Estudo Dirigido 3 – Questão 7
% Resposta ao impulso e estabilidade via Transformada-Z
% H(z) = 1 / (1 - 0.8*z^{-1})
% Disciplina: Processamento Digital de Sinais – IFPB
% =========================================================

clc; clear; close all;

%% Resposta ao impulso: h[n] = 0.8^n * u[n]
N7 = 40;
n7 = 0:N7-1;
h7 = zeros(1, N7);
h7(1) = 1;
for i = 2:N7
    h7(i) = 0.8 * h7(i-1);
end

fprintf('Soma |h[n]| (N=%d): %.4f\n', N7, sum(abs(h7)));
fprintf('Valor teórico 1/(1-0.8) = %.1f\n\n', 1/(1-0.8));

%% Figura única com subplots
figure('Name','Q7 – Transformada-Z e estabilidade','NumberTitle','off');
set(gcf, 'Position', [100 100 1000 420]);

%% Subplot 1 – Resposta ao impulso
subplot(1,2,1);
stem(n7, h7, 'filled', 'b');
grid on;
title('Q7 – Resposta ao impulso h[n] = (0,8)^n u[n]: decaimento exponencial');
xlabel('n'); ylabel('h[n]');

%% Subplot 2 – Diagrama de polos e zeros no plano-Z
subplot(1,2,2);
theta = linspace(0, 2*pi, 300);
plot(cos(theta), sin(theta), 'k--', 'LineWidth', 1);   % círculo unitário
hold on;
plot(0.8, 0, 'rx', 'MarkerSize', 14, 'LineWidth', 2.5);  % polo
plot(0, 0, 'bo', 'MarkerSize', 10, 'LineWidth', 1.5);     % zero na origem
hold off;
grid on; axis equal;
xlim([-1.5 1.5]); ylim([-1.5 1.5]);
legend('Círculo unitário', 'Polo em z = 0,8', 'Zero');
title('Q7 – Plano-Z: polo dentro do círculo unitário → sistema estável');
xlabel('Re(z)'); ylabel('Im(z)');
