# Desafio Proposto – Convolução com Filtro de Média Móvel

---

## Contexto

Considere um sistema de aquisição de dados em que a leitura de um sensor apresenta ruídos rápidos e indesejados. A seguir, explica-se como a **convolução com um filtro de média móvel** pode melhorar a qualidade do sinal medido.

---

## O papel da resposta ao impulso do filtro

Em um filtro de média móvel de ordem `M`, a resposta ao impulso é:

```
h[n] = (1/M) · {1, 1, 1, ..., 1}   (M coeficientes iguais a 1/M)
```

Por exemplo, para um filtro de 3 pontos (como na Atividade 5):
```
h[n] = (1/3){1, 1, 1},   n = 0, 1, 2
```

**O que essa resposta ao impulso representa?**

A resposta ao impulso define como o filtro "enxerga" o sinal ao longo do tempo. No caso da média móvel:

- Cada coeficiente `1/M` indica que o filtro dá **peso igual** a cada uma das `M` amostras dentro da janela de observação.
- O filtro "passa" a janela de tamanho `M` ao longo do sinal, calculando a média local em cada posição.

Matematicamente, a saída do filtro em cada instante é:

```
y[n] = (1/M) · [x[n] + x[n-1] + x[n-2] + ... + x[n-M+1]]
```

Isso equivale exatamente à **convolução** de `x[n]` com `h[n]`:
```
y[n] = x[n] * h[n] = Σ x[k] · h[n-k]
```

---

## Por que ocorre a suavização?

A suavização ocorre por dois mecanismos complementares:

### 1. Perspectiva no domínio do tempo

O ruído presente em sensores geralmente se manifesta como **variações rápidas e aleatórias** de alta amplitude ao redor do sinal real (útil). Ao calcular a média de `M` amostras consecutivas:

- Se o sinal útil varia lentamente, as `M` amostras terão valores próximos, e a média preserva o valor real.
- Se o ruído é aleatório e descorrelacionado, as amostras de ruído tendem a se cancelar parcialmente na média, reduzindo a variância do ruído na saída.

Para ruído branco (média zero, variância `σ²`), a variância do ruído na saída do filtro de M pontos é:
```
σ²_saída = σ²_entrada / M
```
Ou seja, a relação sinal-ruído (SNR) melhora por um fator de `M`.

### 2. Perspectiva no domínio da frequência

A **resposta em frequência** do filtro de média móvel de `M` pontos é:

```
H(ω) = (1/M) · sin(Mω/2) / sin(ω/2) · e^(-jω(M-1)/2)
```

Essa é uma função do tipo **sinc discreta** que:

- **Preserva componentes de baixa frequência** (variações lentas do sinal real): `|H(0)| = 1`
- **Atenua componentes de alta frequência** (ruídos rápidos): `|H(ω)| → 0` para frequências altas

O filtro age, portanto, como um **filtro passa-baixas**, deixando passar as variações lentas (informação) e bloqueando as variações rápidas (ruído).

---

## Possíveis limitações do procedimento

### 1. Atraso (delay de grupo)

O filtro de média móvel de `M` pontos introduz um atraso de `(M-1)/2` amostras. Para `M = 3`, o atraso é de 1 amostra. Em sistemas de controle em tempo real, esse atraso pode afetar a resposta e até causar instabilidade no laço fechado.

### 2. Distorção de borda (efeitos de extremidade)

Nas primeiras e últimas `M-1` amostras do sinal, não há amostras suficientes para preencher a janela de média. Estratégias comuns para lidar com isso incluem: **zero-padding** (preencher com zeros), **replicação de borda** (repetir as amostras extremas) ou **convolução válida** (descartar as amostras de borda).

### 3. Perda de resolução temporal

Ao suavizar, o filtro "mistura" amostras próximas no tempo. Eventos rápidos e legítimos (ex.: picos de corrente em falha elétrica) podem ser atenuados junto com o ruído, dificultando sua detecção. Há um **compromisso** entre suavização e preservação de detalhes.

### 4. Resposta espectral não ideal

O filtro de média simples tem lóbulos laterais significativos na resposta em frequência (não é um filtro passa-baixas ideal). Isso significa que algumas componentes de alta frequência podem não ser totalmente eliminadas. Filtros com janelas mais sofisticadas — como **Hamming**, **Hanning** ou **Kaiser** — têm melhor desempenho de rejeição fora da banda de passagem.

### 5. Escolha do parâmetro M

O valor de `M` (tamanho da janela) deve ser escolhido com cuidado:
- **M pequeno:** pouca suavização, ruído residual elevado.
- **M grande:** boa suavização, mas maior atraso e maior risco de distorcer o sinal útil.

---

## Exemplo ilustrativo

```
Sinal ruidoso do sensor:
x[n] = {2, 5, 4, 6, 8, 7, 5, 4}  +  ruído aleatório de pico ±2

Após filtro de média 3 pontos:
y[n] = {0.67, 2.33, 3.67, 5.00, 6.00, 7.00, 6.67, 5.33, 3.00, 1.33}

Resultado: variações abruptas são suavizadas,
a tendência geral do sinal é preservada.
```

---

## Conclusão

A convolução com um filtro de média móvel é uma técnica simples, eficaz e computacionalmente barata para melhorar a qualidade de sinais de sensores. Seu funcionamento está diretamente relacionado ao papel da resposta ao impulso `h[n]`, que define como as amostras vizinhas são pesadas e combinadas. O efeito de suavização decorre da natureza passa-baixas do filtro, que atenua ruídos de alta frequência enquanto preserva as variações lentas do sinal útil. Suas limitações — atraso, distorção de borda, perda de resolução — devem ser consideradas no contexto da aplicação para garantir um processamento adequado.

---

*Referências: Oppenheim & Schafer (2010); Lyons (2011); Proakis & Manolakis (2007)*
