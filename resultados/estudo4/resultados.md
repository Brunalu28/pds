# Resultados e Discussão Técnica – Estudo Dirigido Parte 4

---

## Síntese dos Resultados por Questão

### Q1 – Filtro passa-baixa em sinal composto

O filtro FIR com corte em $f_c = 0{,}1$ atenuou completamente a componente em $f_2 = 0{,}30$ e preservou $f_1 = 0{,}05$. No espectro de saída, apenas o pico em baixa frequência permaneceu visível, confirmando o funcionamento do filtro como seletor espectral.

---

### Q2 – Redução de ruído com FIR

O filtro FIR de ordem 81 (corte $f_c=0{,}1$) reduziu o RMSE do sinal em relação à senoide original em **85,2%**, recuperando satisfatoriamente a forma de onda. A atenuação na banda de rejeição atingiu aproximadamente $-60\,\text{dB}$, com um atraso de grupo constante de 40 amostras — consequência direta da fase linear do filtro FIR.

---

### Q3 – Comparação com IIR Butterworth

O filtro IIR Butterworth de ordem 5 obteve RMSE praticamente equivalente ao FIR de ordem 81 (diferença de apenas ~5%), porém utilizando **16 vezes menos coeficientes**. Isso evidencia a maior eficiência computacional dos filtros IIR para uma especificação espectral semelhante — ao custo de introduzir distorção de fase não-linear.

---

### Q4 – Resposta em frequência completa

A comparação de magnitude, fase e atraso de grupo confirmou que: (1) o IIR de ordem 6 alcança seletividade espectral comparável ao FIR de ordem 100; (2) a fase do FIR é perfeitamente linear, enquanto a do IIR apresenta forte curvatura próxima ao corte; (3) o atraso de grupo do FIR é constante (50 amostras), mas o do IIR varia significativamente, com pico acentuado na região de transição.

---

### Q5 – Polos, zeros e estabilidade

O filtro Butterworth de ordem 4 apresentou todos os polos com módulo $|p_k| < 1$ (entre 0,64 e 0,89), confirmando estabilidade BIBO. Em contraste, o sistema artificial com polo em $|p| \approx 1{,}26$ (fora do círculo unitário) demonstrou instabilidade, com resposta ao impulso crescente. O diagrama de polos e zeros se mostrou a ferramenta mais direta para verificação de estabilidade.

---

### Q6 – Resposta ao impulso FIR vs IIR

A resposta ao impulso do filtro FIR (ordem 30) apresentou exatamente 31 amostras não-nulas, terminando abruptamente — consequência da ausência de realimentação. A resposta do filtro IIR (Butterworth ordem 4) decaiu exponencialmente, levando aproximadamente 47 amostras para cair abaixo de 1% do valor de pico, sem nunca atingir zero exatamente — ilustrando teoricamente a duração infinita.

---

### Q7 – Filtro passa-faixa

O filtro FIR passa-faixa com banda $[0{,}10-0{,}20]$ isolou com sucesso a componente em $f=0{,}15$ de um sinal contendo três frequências distintas (0,05, 0,15 e 0,35). No domínio do tempo, a saída tornou-se uma senoide limpa correspondente apenas à frequência selecionada.

---

### Q8 – Resposta de fase e linearidade

O filtro FIR (ordem 50) confirmou fase exatamente linear, com atraso de grupo constante de 25 amostras em toda a faixa de frequências. O filtro IIR Butterworth (ordem 5) apresentou fase não-linear, com atraso de grupo variável e pico pronunciado próximo à frequência de corte — demonstrando a distorção de fase característica de filtros IIR.

---

### Q9 – Comparação de atraso de grupo

Os atrasos de grupo médios medidos foram: FIR ordem 31 (15,0 amostras, constante), FIR ordem 101 (50,0 amostras, constante), IIR Butterworth ordem 3 (3,2 amostras médio, pico de 18,7) e IIR Butterworth ordem 8 (7,1 amostras médio, pico de 52,3). Filtros IIR de ordem mais alta apresentam picos de atraso comparáveis aos filtros FIR, perdendo parte da vantagem de baixo atraso médio.

---

### Q10 – Aplicação prática: sensor agrícola

Na simulação de um sensor de umidade do solo contaminado por ruído elétrico e um pico de interferência, ambos os filtros (FIR ordem 61 e IIR Butterworth ordem 3, corte $f_c=0{,}05$) reduziram o RMSE de **2,68** (sinal ruidoso) para aproximadamente **0,39–0,41** — uma melhoria de cerca de 85%. O filtro IIR, com apenas 3 coeficientes de realimentação, atingiu desempenho equivalente ao FIR com fração do custo computacional, tornando-se a opção mais adequada para microcontroladores de baixo consumo.

---

## Resposta ao Problema Norteador

**Um sistema de monitoramento agrícola utiliza sensores para medir variáveis ambientais e operacionais, mas os sinais adquiridos apresentam ruídos e interferências. Como projetar e validar filtros digitais capazes de reduzir os ruídos sem comprometer as informações relevantes?**

A simulação da Questão 10 demonstrou um fluxo completo de projeto e validação: (1) caracterização do sinal de interesse como de baixa frequência (variação lenta de umidade) e do ruído como de alta frequência (ruído elétrico e interferências); (2) projeto de filtros passa-baixa FIR e IIR com frequência de corte adequada para separar essas faixas; (3) validação quantitativa via RMSE em relação ao sinal de referência conhecido.

A escolha entre FIR e IIR neste contexto depende de prioridades específicas do sistema:

- **FIR** é preferível quando a integridade da forma de onda e a previsibilidade do atraso são críticas — por exemplo, quando múltiplos sensores precisam ser sincronizados temporalmente.
- **IIR** é preferível em sistemas embarcados com recursos limitados (ESP32, STM32, Arduino), onde o número de operações por amostra impacta diretamente o consumo de energia e a taxa de amostragem máxima viável.

**Limitação identificada:** picos de interferência isolados e de curta duração (como o simulado em $n=200$) não são completamente eliminados por filtros lineares passa-baixa, pois sua energia se distribui por múltiplas frequências. Para esses casos, filtros não-lineares (como o filtro de mediana) seriam mais eficazes, podendo ser combinados em cascata com o filtro passa-baixa linear.

**Conclusão geral:** a validação por métricas quantitativas (RMSE) é essencial para garantir que a filtragem não esteja comprometendo informações relevantes — um filtro mal projetado (corte muito baixo) poderia eliminar variações reais e legítimas do sinal de interesse, mascarando eventos importantes para a tomada de decisão agrícola.

---

## Referências

- OPPENHEIM, A. V.; SCHAFER, R. W. *Discrete-Time Signal Processing*. 3. ed. Pearson, 2010.
- PROAKIS, J. G.; MANOLAKIS, D. G. *Digital Signal Processing: Principles, Algorithms, and Applications*. 4. ed. Pearson, 2007.
- LYONS, R. G. *Understanding Digital Signal Processing*. 3. ed. Pearson, 2011.