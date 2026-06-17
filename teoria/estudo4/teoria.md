# Resumo Teórico – Filtros Digitais

## 1. Introdução

Um **filtro digital** é um sistema discreto LTI projetado para modificar seletivamente o conteúdo espectral de um sinal. Em vez de amplificar ou atenuar indiscriminadamente, o filtro age de forma diferenciada sobre cada faixa de frequência: preserva as componentes de interesse e atenua ou elimina as indesejadas. Essa capacidade de separação espectral é fundamental em aplicações que vão desde a remoção de ruído em sensores agrícolas até o condicionamento de sinais em sistemas de telecomunicações 5G (OPPENHEIM; SCHAFER, 2010).

A resposta em frequência $H(e^{j\omega})$ de um filtro LTI descreve completamente seu comportamento espectral: para cada frequência $\omega$, o módulo $|H(e^{j\omega})|$ indica o ganho aplicado (quanto o filtro amplifica ou atenua aquela componente) e o argumento $\angle H(e^{j\omega})$ indica o deslocamento de fase introduzido. O projeto de um filtro digital consiste em encontrar os coeficientes que fazem com que $H(e^{j\omega})$ se aproxime de uma especificação desejada — por exemplo, ganho unitário abaixo de uma frequência de corte $\omega_c$ e ganho zero acima dela.

---

## 2. Filtros FIR (Finite Impulse Response)

Os filtros FIR possuem resposta ao impulso **finita**, com duração de $M$ amostras. Sua equação de diferenças tem a forma:

$$y[n] = \sum_{k=0}^{M-1} b_k\, x[n-k]$$

onde $b_k$ são os coeficientes do filtro, diretamente iguais aos valores da resposta ao impulso $h[k]$. Por não possuírem realimentação (sem termos $y[n-k]$), os filtros FIR são **intrinsecamente estáveis** — todos os seus polos estão na origem do plano-Z.

A propriedade mais importante dos filtros FIR é a possibilidade de **fase linear exata**. Quando os coeficientes são simétricos ($b_k = b_{M-1-k}$), o filtro introduz um atraso de grupo constante em todas as frequências, preservando a forma de onda do sinal filtrado. Isso é crítico em aplicações como ECG, processamento de áudio de alta fidelidade e comunicações digitais, onde distorções de fase causam degradação perceptível.

A desvantagem dos filtros FIR é que, para alcançar alta seletividade espectral (transição estreita entre banda passante e banda de rejeição), é necessário um número elevado de coeficientes $M$, resultando em maior custo computacional ($M$ multiplicações por amostra) e maior atraso de grupo ($(M-1)/2$ amostras) (PROAKIS; MANOLAKIS, 2007).

**Métodos de projeto:** janelamento (retangular, Hamming, Kaiser), equiripple (Parks-McClellan), frequência amostrada.

---

## 3. Filtros IIR (Infinite Impulse Response)

Os filtros IIR possuem **realimentação**: a saída depende de amostras anteriores da própria saída. A equação geral é:

$$y[n] = \sum_{k=0}^{M} b_k\, x[n-k] - \sum_{k=1}^{N} a_k\, y[n-k]$$

A resposta ao impulso de um filtro IIR decai gradualmente (teoricamente ao infinito), pois a realimentação permite que cada amostra influencie indefinidamente as amostras futuras. Essa estrutura possibilita alta seletividade espectral com **ordens muito menores** que os filtros FIR equivalentes, reduzindo significativamente o custo computacional.

A contrapartida é que filtros IIR **não garantem fase linear**. A resposta de fase é não-linear, introduzindo distorção de fase diferente para cada frequência — o que pode ser problemático em aplicações sensíveis à forma de onda. Além disso, a presença de realimentação exige atenção à estabilidade: para que um filtro IIR seja estável, todos os seus polos devem estar dentro do círculo unitário no plano-Z.

**Métodos de projeto:** transformação de filtros analógicos (Butterworth, Chebyshev I e II, Elíptico) para o domínio discreto via transformação bilinear ou invariância ao impulso.

---

## 4. Comparação FIR vs IIR

| Aspecto | FIR | IIR |
|---|---|---|
| **Estabilidade** | Sempre estável (polos na origem) | Depende da localização dos polos |
| **Fase** | Linear exata (coef. simétricos) | Não-linear |
| **Ordem para mesma seletividade** | Alta (dezenas a centenas) | Baixa (5–10 típico) |
| **Custo computacional** | Maior (mais multiplicações) | Menor |
| **Atraso de grupo** | Constante e previsível | Variável com a frequência |
| **Estrutura** | Sem realimentação (FIR direto) | Com realimentação |
| **Aplicações típicas** | Áudio, ECG, comunicações | Controle, instrumentação, EEG |

---

## 5. Resposta em Frequência e Resposta de Fase

A **resposta em frequência** é obtida avaliando a função de transferência $H(z)$ sobre o círculo unitário:

$$H(e^{j\omega}) = \sum_{n=-\infty}^{+\infty} h[n]\, e^{-j\omega n}$$

O **módulo** $|H(e^{j\omega})|$ define a resposta em magnitude (ganho por frequência), enquanto o **argumento** $\angle H(e^{j\omega})$ define a resposta de fase.

A **fase linear** significa que $\angle H(e^{j\omega}) = -\alpha\omega$ para alguma constante $\alpha$. Nesse caso, todas as componentes de frequência sofrem o mesmo atraso temporal $\alpha$ amostras, preservando a forma de onda. Filtros IIR têm fase não-linear, o que significa que componentes de frequências diferentes chegam à saída com atrasos diferentes — distorcendo o sinal no tempo.

---

## 6. Atraso de Grupo

O **atraso de grupo** é definido como a derivada negativa da fase em relação à frequência:

$$\tau(\omega) = -\frac{d\,\angle H(e^{j\omega})}{d\omega}$$

Fisicamente, $\tau(\omega)$ representa o atraso (em amostras) sofrido pela envoltória de um componente de frequência $\omega$ ao atravessar o filtro. Para filtros FIR com fase linear, $\tau(\omega) = (M-1)/2$ = constante: todos os componentes chegam juntos à saída. Para filtros IIR, $\tau(\omega)$ varia com $\omega$, causando dispersão temporal dos componentes espectrais do sinal.

Em sistemas de comunicação digital, atraso de grupo não-constante causa **distorção de grupo** (ou dispersão de modo), que alarga pulsos e aumenta a taxa de erro de bit (BER). Em processamento de áudio, a distorção de fase pode afetar a qualidade perceptiva do som, especialmente em frequências baixas (LYONS, 2011).

---

## 7. Polos, Zeros e Estabilidade

A função de transferência de um filtro digital pode ser expressa como:

$$H(z) = \frac{B(z)}{A(z)} = \frac{b_0 + b_1 z^{-1} + \cdots + b_M z^{-M}}{1 + a_1 z^{-1} + \cdots + a_N z^{-N}}$$

Os **zeros** de $H(z)$ (raízes de $B(z)$) determinam as frequências de **anulação** do filtro: em $\omega$ tal que $z = e^{j\omega}$ seja um zero, a resposta em magnitude é zero. Os **polos** (raízes de $A(z)$) determinam as frequências de **ressonância**: quanto mais próximo o polo estiver do círculo unitário, maior o pico de ganho naquela frequência.

**Condição de estabilidade BIBO para filtros IIR:** todos os polos devem satisfazer $|p_k| < 1$, ou seja, estar estritamente dentro do círculo unitário no plano-Z. Filtros FIR têm todos os polos na origem ($z = 0$), garantindo estabilidade incondicional (OPPENHEIM; SCHAFER, 2010).

---

## 8. Custo Computacional

O custo computacional de um filtro digital é medido em número de **multiplicações acumuladas** (MAC — *Multiply-Accumulate*) por amostra:

- **FIR de ordem M:** exige $M$ MACs por amostra de saída.
- **IIR de ordem N:** exige $N + M$ MACs por amostra (termos de feedforward + feedback).

Em sistemas embarcados e DSPs, onde o clock é limitado, o número de MACs é o principal fator que determina a taxa de amostragem máxima. Um filtro FIR de ordem 100 exige o dobro de operações que um IIR de ordem 5 com desempenho espectral similar — diferença decisiva em microcontroladores para TinyML e IoT agrícola.

---

## 9. Aplicações Práticas

- **Monitoramento agrícola (IoT):** Filtros passa-baixas FIR ou IIR removem ruído de sensores de umidade, temperatura e pH, preservando as variações lentas de interesse agronômico.
- **Processamento de áudio:** Equalizadores paramétricos usam filtros IIR de 2ª ordem (biquad); processamento de alta fidelidade usa FIR com fase linear.
- **Telecomunicações:** Filtros de conformação de pulso (raised cosine) em sistemas OFDM são tipicamente FIR, garantindo ausência de ISI (*intersymbol interference*).
- **Monitoramento de vibração:** Filtros passa-faixa selecionam harmônicos específicos associados a tipos de defeito em rolamentos ou engrenagens.
- **Pré-processamento para TinyML:** Filtros IIR de baixa ordem são preferidos em microcontroladores (STM32, ESP32) por minimizar o uso de memória e ciclos de clock.

---

## Referências

- OPPENHEIM, A. V.; SCHAFER, R. W. *Discrete-Time Signal Processing*. 3. ed. Pearson, 2010.
- PROAKIS, J. G.; MANOLAKIS, D. G. *Digital Signal Processing: Principles, Algorithms, and Applications*. 4. ed. Pearson, 2007.
- LYONS, R. G. *Understanding Digital Signal Processing*. 3. ed. Pearson, 2011.