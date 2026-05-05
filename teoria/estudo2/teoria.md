# Atividade 1 – Interpretação Conceitual
---

## 1) O que significa afirmar que um sistema é linear e invariante no tempo?

Um sistema é **linear** quando satisfaz simultaneamente dois princípios:

- **Superposição:** se a entrada for uma soma de sinais, a saída será a soma das saídas correspondentes a cada sinal individualmente.
- **Homogeneidade (escalonamento):** se a entrada for multiplicada por uma constante, a saída também será multiplicada pela mesma constante.

Formalmente, para um sistema `T{·}`:

```
Se T{x₁[n]} = y₁[n]  e  T{x₂[n]} = y₂[n], então:
T{a·x₁[n] + b·x₂[n]} = a·y₁[n] + b·y₂[n]
```

Um sistema é **invariante no tempo** quando seu comportamento não muda ao longo do tempo. Ou seja, se a entrada for deslocada de `k` amostras, a saída também será deslocada das mesmas `k` amostras, sem qualquer alteração na forma:

```
Se T{x[n]} = y[n], então T{x[n - k]} = y[n - k]  para qualquer k ∈ ℤ
```

**Em resumo:** um sistema LTI (Linear e Invariante no Tempo) é aquele que obedece à superposição e cujas características não variam com o tempo.

---

## 2) Por que a resposta ao impulso é suficiente para caracterizar um sistema LTI?

Qualquer sinal discreto `x[n]` pode ser decomposto como uma soma ponderada de impulsos deslocados:

```
x[n] = Σ x[k] · δ[n - k]   (para k de -∞ a +∞)
```

Como o sistema é **linear**, a saída para essa soma é a soma das saídas para cada impulso deslocado. Como o sistema é **invariante no tempo**, a resposta a um impulso deslocado `δ[n - k]` é simplesmente `h[n - k]`, ou seja, a resposta ao impulso deslocada.

Portanto:

```
y[n] = Σ x[k] · h[n - k]   (convolução)
```

Isso demonstra que, conhecendo apenas `h[n]`, é possível calcular a saída para **qualquer entrada** `x[n]`. A resposta ao impulso contém toda a informação necessária sobre o sistema.

---

## 3) Qual o significado físico da convolução em sistemas discretos?

A convolução discreta entre `x[n]` e `h[n]` pode ser interpretada de duas maneiras complementares:

1. **Perspectiva da entrada:** cada amostra `x[k]` da entrada gera uma versão escalonada da resposta ao impulso `x[k] · h[n - k]`. A saída total é a sobreposição (soma) de todas essas contribuições ao longo do tempo.

2. **Perspectiva do filtro:** em cada instante `n`, a saída `y[n]` é uma combinação linear ponderada das amostras passadas (e presentes) da entrada, com os pesos definidos pela resposta ao impulso `h[n]`.

**Fisicamente**, a convolução representa como o sistema "processa" a entrada ao longo do tempo. Em aplicações de filtragem, ela determina quais componentes do sinal são amplificados, atenuados ou eliminados.

---

## 4) Qual a diferença entre resposta transitória e regime permanente?

| Aspecto | Resposta Transitória | Regime Permanente |
|---|---|---|
| **Definição** | Comportamento inicial do sistema após a aplicação da entrada | Comportamento estável após o transitório decair |
| **Duração** | Curta, depende da "memória" do sistema | Longa (ou indefinida) |
| **Origem** | Condições iniciais e dinâmica interna | Influência contínua da entrada |
| **Exemplo** | Oscilações ou crescimento/decaimento rápido logo após `n = 0` | Resposta senoidal constante a uma entrada senoidal |

Em sistemas estáveis, a resposta transitória decai para zero ao longo do tempo, restando apenas o regime permanente. Em sistemas instáveis, a resposta transitória pode crescer indefinidamente.

---

## 5) O que se entende por sistema causal?

Um sistema é **causal** quando a saída em qualquer instante `n` depende **apenas das amostras presentes e passadas** da entrada, nunca de amostras futuras.

```
y[n] depende apenas de  x[n], x[n-1], x[n-2], ...
```

Matematicamente, para um sistema LTI causal, a resposta ao impulso satisfaz:

```
h[n] = 0  para  n < 0
```

**Por que é importante?** Em sistemas em tempo real (como controle e comunicações), não é possível ter acesso a amostras futuras da entrada. Portanto, implementações práticas exigem sistemas causais.

> **Exemplo causal:** `y[n] = x[n] + x[n-1]`  
> **Exemplo não causal:** `y[n] = x[n+1]` (usa amostra futura da entrada)

---

## 6) O que se entende por sistema estável?

Um sistema é **estável no sentido BIBO** (*Bounded Input, Bounded Output* — entrada limitada, saída limitada) quando toda entrada com amplitude finita produz uma saída com amplitude finita.

```
Se |x[n]| ≤ Mx < ∞  para todo n,
então |y[n]| ≤ My < ∞  para todo n
```

Para sistemas LTI, a condição **necessária e suficiente** de estabilidade BIBO é que a resposta ao impulso seja absolutamente somável:

```
Σ |h[n]| < ∞   (para n de -∞ a +∞)
```

**Intuição:** se `h[n]` decai rapidamente para zero, o sistema não acumula energia indefinidamente, garantindo que a saída permaneça limitada.

> **Exemplo estável:** `h[n] = (0.5)ⁿ u[n]` → série geométrica convergente  
> **Exemplo instável:** `h[n] = 2ⁿ u[n]` → série divergente

---

*Referências: Oppenheim & Schafer (2010); Proakis & Manolakis (2007)*
