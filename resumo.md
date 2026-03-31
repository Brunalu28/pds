# Resumo Teórico: Modelagem de Sinais e Sistemas Discretos

Este documento apresenta a fundamentação teórica baseada nas obras de Oppenheim, Lathi e Proakis para o estudo de Processamento Digital de Sinais (PDS), conectando os conceitos matemáticos com aplicações práticas na engenharia.

---

## 1. Sinais Contínuos e Discretos
Conforme discutido por Oppenheim, os sinais representam matematicamente fenômenos físicos como funções de uma ou mais variáveis independentes. Para distinguir rigorosamente as representações, a literatura adota a variável independente entre parênteses, $x(t)$, para denotar sinais de tempo contínuo, e a variável entre colchetes, $x[n]$, para sinais de tempo discreto.

Os sinais discretos são definidos somente em instantes discretos, com a variável independente assumindo apenas um conjunto de valores inteiros. Embora uma classe muito importante de sinais discretos decorra da amostragem de sinais contínuos, eles também podem representar fenômenos cuja variável independente é inerentemente discreta (como índices econômicos ou dados demográficos).

Matematicamente, o processo de amostragem converte um sinal contínuo $x(t)$ em uma sequência discreta $x[n]$ avaliando o sinal em intervalos de tempo uniformes $T_s$ (período de amostragem):

$$
x[n] = x(n \cdot T_s), \quad -\infty < n < \infty
$$

onde $n$ é um número inteiro que representa o índice da amostra.

## 2. Sequências Elementares
A análise e o projeto de sistemas discretos apoiam-se em sequências matemáticas básicas:

* **Impulso Unitário ($\delta[n]$):** Fundamental para descrever a resposta ao impulso de um sistema.

$$
\delta[n] = \begin{cases} 1, & \text{se } n = 0 \\ 0, & \text{se } n \neq 0 \end{cases}
$$

* **Degrau Unitário ($u[n]$):** Muito utilizado na análise de causalidade e na modelagem de sinais que são ativados em $n=0$.

$$
u[n] = \begin{cases} 1, & \text{se } n \geq 0 \\ 0, & \text{se } n < 0 \end{cases}
$$

* **Exponenciais Complexas:** Têm a forma genérica $x[n] = A \cdot \alpha^n$. São a base matemática da Transformada de Fourier para Tempo Discreto (DTFT) e da Transformada Z.

## 3. Transformações da Variável Independente
Um conceito fundamental na análise de sinais é a transformação elementar da variável independente, ou seja, a modificação do eixo do tempo. Uma transformação na forma $x(\alpha n + \beta)$ permite realizar as seguintes operações básicas:
* **Deslocamento no Tempo:** Representado por $x[n-n_0]$. Corresponde a um atraso se $n_0 > 0$ ou a um avanço se $n_0 < 0$. É essencial na modelagem de buffers de memória e reflexo de diferenças no tempo de propagação.
* **Inversão (Reflexão) no Tempo:** Representada por $x[-n]$. Resulta do espelhamento do sinal em relação à origem ($n=0$).
* **Mudança de Escala no Tempo:** O sinal sofre compressão linear se o módulo do fator multiplicativo for maior que 1 ($|\alpha| > 1$) e expansão/extensão linear se menor que 1 ($|\alpha| < 1$).

## 4. Energia e Potência de Sinais
A caracterização energética dos sinais constitui uma etapa essencial para relacioná-los a quantidades físicas de um sistema.
* **Energia Total ($E_\infty$):** Definida como o limite da soma dos quadrados das magnitudes do sinal em um intervalo infinito.

$$
E_\infty = \sum_{n=-\infty}^{\infty} |x[n]|^2
$$

* **Potência Média ($P_\infty$):** Definida para um intervalo de duração infinita.

$$
P_\infty = \lim_{N \to \infty} \frac{1}{2N+1} \sum_{n=-N}^{N} |x[n]|^2
$$

A partir destas métricas, identificam-se três importantes classes de sinais:
1. **Sinais de Energia Finita:** Sinais onde $E_\infty < \infty$. Obrigatoriamente, possuem potência média igual a zero ($P_\infty = 0$).
2. **Sinais de Potência Finita:** Sinais com potência média diferente de zero ($P_\infty > 0$), o que implica necessariamente que possuem energia total infinita ($E_\infty = \infty$).
3. **Sinais Divergentes:** Sinais para os quais nem a energia nem a potência média assumem valores finitos.

## 5. Classificação de Sistemas Discretos
Segundo Lathi, modelar sistemas exige identificar propriedades que determinam seu comportamento dinâmico. Um sistema mapeia uma entrada $x[n]$ para uma saída $y[n]$.

* **Memória:** Um sistema não tem memória se $y[n]$ depende apenas de $x[n]$ (instante atual). Tem memória se usar amostras passadas ($x[n-1]$) ou futuras.
* **Linearidade:** Obedece ao Princípio da Superposição. A resposta a uma soma ponderada de entradas é a soma ponderada das respostas individuais.
* **Causalidade:** A saída $y[n]$ depende apenas de entradas presentes e passadas ($x[n], x[n-1]$). Não pode prever o futuro ($x[n+1]$).
* **Invariância no Tempo:** Um atraso na entrada causa o exato mesmo atraso na saída, independentemente do instante de observação.
* **Estabilidade BIBO (Bounded-Input Bounded-Output):** Toda entrada de amplitude limitada gera uma saída de amplitude limitada. Garante que o sistema não divirja para o infinito.

---

## 6. Aplicações Tecnológicas e Sinais Reais
A ligação entre a teoria de sinais discretos e a prática da engenharia concretiza-se através da análise de sinais provenientes de sistemas reais. As propriedades estruturais dos sistemas digitais ditam a forma como os seguintes sinais são processados:

* **Sinais de vibração em máquinas rotativas:** São sinais tipicamente de alta frequência e com grande conteúdo harmônico. A modelagem matemática requer uma amostragem rigorosa (respeitando o Teorema de Nyquist) para evitar o fenômeno de *aliasing*. O processamento digital destes sinais é crucial para a manutenção preditiva, utilizando sistemas Lineares e Invariantes no Tempo (LTI) para filtragem de ruídos indesejados.

* **Sinais térmicos provenientes de sensores industriais:** A temperatura é uma grandeza física de variação lenta, mas os sensores captam ruídos elétricos de alta frequência (ex: 60 Hz da rede). O processamento digital envolve tipicamente sistemas "com memória", como filtros de média móvel, para suavizar o sinal e garantir uma leitura estável, atuando como um filtro passa-baixas.

* **Sinais elétricos em sistemas digitais:** Referem-se a tensões ou correntes monitoradas em barramentos e circuitos de comunicação. A análise matemática de energia e potência discreta é vital para calcular o consumo computacional, garantindo a integridade e a eficiência da informação transmitida por pacotes de bits.

* **Sinais de velocidade e rotação de eixos:** Frequentemente obtidos através de *encoders* óticos ou magnéticos, que geram pulsos. A modelagem digital avalia a variação da posição ao longo das amostras (usando um sistema derivador discreto: $v[n] = x[n] - x[n-1]$) para calcular a velocidade de forma estritamente algorítmica.

* **Sinais adquiridos por sistemas embarcados:** Microcontroladores interagem com o mundo físico através de ADCs. A implementação de algoritmos de PDS nestes sistemas exige que o modelo seja estritamente **causal** (pois o hardware opera em tempo real e não conhece amostras futuras) e **estável** (BIBO). Um sistema instável processando ruído levará a valores matemáticos divergentes, causando *overflow* na memória do microcontrolador e travamento do sistema.

---

## 7. Resolução do Problema Norteador

**Problema:** *Como representar matematicamente o comportamento temporal de um sensor real e quais propriedades estruturais devem ser analisadas para garantir o correto processamento digital desse sinal?*

**Conclusão Analítica:**
O comportamento de um sensor real (analógico) é inicialmente representado por uma função contínua no tempo, $x(t)$. Para processamento digital, este sinal é discretizado temporalmente e em amplitude por um conversor A/D, gerando a representação matemática $x[n] = x(nT_s)$. 

Para garantir o sucesso do processamento em um sistema físico digital, a modelagem deve garantir obrigatoriamente duas propriedades estruturais:
1. **Causalidade:** O algoritmo de processamento só pode utilizar amostras do instante atual ($n$) e de instantes anteriores ($n-1, n-2...$). 
2. **Estabilidade BIBO:** Garante que o acúmulo de operações matemáticas sobre variações do sensor (ou ruídos) não resulte em saídas tendendo ao infinito.

Adicionalmente, modelar a solução computacional como um sistema **LTI (Linear e Invariante no Tempo)** viabiliza o uso da convolução matemática, que é a operação base para o funcionamento de filtros digitais (FIR e IIR) utilizados para extrair a informação útil do sensor, rejeitando as interferências inerentes ao ambiente industrial.
