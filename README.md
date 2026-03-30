# Processamento Digital de Sinais - Estudo Dirigido 1
**Curso:** Engenharia da Computação / Telemática - IFPB
**Tema:** Modelagem de Sinais e Sistemas Discretos

## Objetivos
Este repositório contém o desenvolvimento do primeiro Estudo Dirigido de PDS, focado nos fundamentos matemáticos da representação e análise de sinais discretos, bem como na classificação de sistemas digitais e sua relação com aplicações reais na engenharia.

## Estrutura do Repositório
* `/teoria`: Contém o resumo teórico fundamentado (baseado em Oppenheim, Lathi e Proakis). Aborda sinais contínuos/discretos, operações elementares, energia/potência e propriedades de sistemas (linearidade, causalidade, memória, invariância e estabilidade).
* `/simulacoes`: Códigos em Python (`.py` e/ou Jupyter Notebooks) demonstrando a geração de sinais elementares (impulso, degrau, exponenciais) e operações matemáticas aplicadas a esses sinais.
* `/resultados`: Gráficos gerados pelas simulações computacionais e uma breve discussão técnica que valida a teoria através da prática.

## Aplicações Tecnológicas Abordadas
Os conceitos matemáticos desenvolvidos neste trabalho foram diretamente relacionados com o processamento de:
- Sinais de vibração em máquinas rotativas;
- Sinais térmicos provenientes de sensores industriais;
- Sinais elétricos em sistemas digitais;
- Sinais de velocidade e rotação de eixos;
- Sinais adquiridos por sistemas embarcados.

## Resolução do Problema Norteador
**Como representar matematicamente o comportamento temporal de um sensor real e quais propriedades estruturais devem ser analisadas para garantir o correto processamento digital desse sinal?**

**Resposta resumida (ver documento completo em `/teoria`):**
O sinal do sensor contínuo $x(t)$ é representado matematicamente como uma sequência discreta $x[n] = x(nT_s)$ após a amostragem. Para que o processamento digital seja viável e correto num sistema real (como num microcontrolador), o sistema projetado deve ser estritamente **causal** (dependendo apenas de amostras atuais e passadas) e **estável** no sentido BIBO (para que ruídos não levem a saídas que tendem ao infinito). A adoção de sistemas **Lineares e Invariantes no Tempo (LTI)** é também frequentemente necessária para viabilizar a eliminação de ruídos (filtragem).
