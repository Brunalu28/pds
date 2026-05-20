# Processamento Digital de Sinais
**Curso:** Engenharia da Computação / Telemática - IFPB
**Tema:** Modelagem de Sinais, Sistemas Discretos, Convolução, Sistemas LTI e Análise Espectral

---

## Estudo Dirigido 1 – Modelagem de Sinais e Sistemas Discretos

### Objetivos
Desenvolvimento dos fundamentos matemáticos da representação e análise de sinais discretos, bem como na classificação de sistemas digitais e sua relação com aplicações reais na engenharia.

### Estrutura
* `/teoria/estudo1`: Resumo teórico fundamentado (baseado em Oppenheim, Lathi e Proakis). Aborda sinais contínuos/discretos, operações elementares, energia/potência e propriedades de sistemas (linearidade, causalidade, memória, invariância e estabilidade).
* `/simulações/estudo1`: Códigos em Python (Jupyter Notebooks) demonstrando a geração de sinais elementares (impulso, degrau, exponenciais) e operações matemáticas aplicadas a esses sinais.
* `/resultados/estudo1`: Gráficos gerados pelas simulações computacionais e uma breve discussão técnica que valida a teoria através da prática.

### Aplicações Tecnológicas Abordadas
Os conceitos matemáticos desenvolvidos foram diretamente relacionados com o processamento de:
- Sinais de vibração em máquinas rotativas;
- Sinais térmicos provenientes de sensores industriais;
- Sinais elétricos em sistemas digitais;
- Sinais de velocidade e rotação de eixos;
- Sinais adquiridos por sistemas embarcados.

### Resolução do Problema Norteador
**Como representar matematicamente o comportamento temporal de um sensor real e quais propriedades estruturais devem ser analisadas para garantir o correto processamento digital desse sinal?**

**Resposta resumida (ver documento completo em `/teoria/estudo1`):**
O sinal do sensor contínuo $x(t)$ é representado matematicamente como uma sequência discreta $x[n] = x(nT_s)$ após a amostragem. Para que o processamento digital seja viável e correto num sistema real (como num microcontrolador), o sistema projetado deve ser estritamente **causal** (dependendo apenas de amostras atuais e passadas) e **estável** no sentido BIBO (para que ruídos não levem a saídas que tendem ao infinito). A adoção de sistemas **Lineares e Invariantes no Tempo (LTI)** é também frequentemente necessária para viabilizar a eliminação de ruídos (filtragem).

---

## Estudo Dirigido 2 – Convolução e Sistemas LTI

### Objetivos
Aprofundamento no conceito de sistemas LTI, com foco na resposta ao impulso como elemento central da caracterização de sistemas discretos, no cálculo da convolução, na análise de equações de diferenças e na aplicação desses conceitos em filtragem e suavização de sinais.

### Estrutura
* `/teoria/estudo2`: Respostas conceituais (Atividade 1), análise do sistema por equação de diferenças (Atividade 3), análise de estabilidade e causalidade (Atividade 6) e desafio sobre filtro de média móvel.
* `/simulações/estudo2`: Jupyter Notebook com implementação computacional da convolução discreta e suavização de sinais (Atividades 4 e 5), incluindo gráficos gerados com `numpy` e `matplotlib`.
* `/resultados/estudo2`: Cálculo manual da convolução $x[n] * h[n]$ (Atividade 2) com apresentação passo a passo e interpretação do resultado.

### Aplicações Tecnológicas Abordadas
Os conceitos desenvolvidos foram aplicados em:
- Filtragem de sinais provenientes de sensores industriais;
- Suavização de sinais ruidosos por média móvel;
- Implementação e análise de filtros digitais simples;
- Análise temporal de sistemas discretos por equações de diferenças.

### Resolução do Problema Norteador
**Como determinar a saída de um sistema discreto para qualquer entrada e como garantir que esse sistema seja estável e causal?**

**Resposta resumida (ver documentos completos em `/teoria/estudo2`):**
A saída de um sistema LTI é completamente determinada pela convolução $y[n] = x[n] * h[n]$, onde $h[n]$ é a resposta ao impulso — suficiente para caracterizar o sistema inteiramente. A causalidade exige $h[n] = 0$ para $n < 0$, garantindo que a saída dependa apenas de entradas presentes e passadas. A estabilidade BIBO é garantida quando $\sum |h[n]| < \infty$. Em aplicações práticas, como a suavização de leituras de sensores, o filtro de média móvel exemplifica esses conceitos ao atuar como passa-baixas, atenuando ruídos de alta frequência e preservando a tendência geral do sinal.

---

## Estudo Dirigido 3 – Análise no Domínio da Frequência

### Objetivos
Introdução à análise espectral de sinais discretos, compreendendo como a informação de um sinal se distribui no domínio da frequência por meio da DTFT, DFT, FFT e Transformada-Z, além da investigação dos efeitos de aliasing e janelamento.

### Estrutura
* `/teoria/estudo3`: Resumo teórico fundamentado cobrindo DTFT, DFT, FFT, Transformada-Z, aliasing e janelamento, com interpretações físicas e exemplos práticos.
* `/simulações/estudo3`: Jupyter Notebook com 10 simulações computacionais — geração e análise espectral de senoides, detecção de aliasing, comparação de janelas, análise com ruído, equivalência DFT/FFT, análise de estabilidade pelo plano-Z, resolução espectral, identificação de harmônicos e análise de vibração mecânica simulada.
* `/resultados/estudo3`: Discussão técnica dos resultados de cada simulação e resposta ao problema norteador da etapa.

### Aplicações Tecnológicas Abordadas
- Análise espectral de vibração em máquinas rotativas;
- Diagnóstico de falhas mecânicas por assinaturas de harmônicos;
- Processamento de sinais de áudio e telecomunicações;
- Análise espectral de sinais adquiridos por sistemas embarcados;
- Manutenção preditiva industrial baseada em análise de frequência.

### Resolução do Problema Norteador
**Como identificar, a partir do conteúdo espectral de um sinal real, informações relevantes sobre o comportamento dinâmico de um sistema físico e quais limitações práticas devem ser consideradas?**

**Resposta resumida (ver documentos completos em `/teoria/estudo3` e `/resultados/estudo3`):**
A FFT permite decompor qualquer sinal discreto em suas componentes de frequência, revelando frequências dominantes, harmônicos e ruídos inacessíveis no domínio do tempo. Em sistemas mecânicos, cada pico espectral tem significado físico direto: a fundamental indica a velocidade de operação e os harmônicos caracterizam tipos específicos de defeito. As limitações práticas fundamentais são o **aliasing** (exige $f_s \geq 2f_{max}$ e filtro antialiasing), o **vazamento espectral** (controlado pela escolha da janela) e a **resolução espectral** ($\Delta f = f_s/N$). A combinação adequada desses parâmetros determina a qualidade da análise espectral em aplicações reais de engenharia.