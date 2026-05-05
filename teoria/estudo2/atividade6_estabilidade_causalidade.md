# Atividade 6 – Análise de Estabilidade e Causalidade
---

## Conceitos fundamentais

**Causalidade:** Um sistema LTI é causal se e somente se `h[n] = 0` para todo `n < 0`. Fisicamente: a saída não depende de entradas futuras.

**Estabilidade BIBO:** Um sistema LTI é estável se e somente se:
```
Σ |h[n]| < ∞   (soma absolutamente convergente)
```

---

## a) y[n] = x[n] + x[n − 1]

### Identificação da resposta ao impulso

Aplicando `x[n] = δ[n]`:
```
h[n] = δ[n] + δ[n-1]
```

Portanto:
```
h[0] = 1,  h[1] = 1,  h[n] = 0  para os demais n
```

### Causalidade

```
h[n] = 0  para n < 0  ✅
```
O sistema depende apenas de `x[n]` (presente) e `x[n-1]` (passado).

> **Conclusão: Sistema CAUSAL ✅**

### Estabilidade BIBO

```
Σ |h[n]| = |h[0]| + |h[1]| = 1 + 1 = 2 < ∞  ✅
```

> **Conclusão: Sistema ESTÁVEL ✅**

### Resumo

| Propriedade | Resultado |
|---|---|
| Causal | ✅ Sim |
| Estável (BIBO) | ✅ Sim |

**Interpretação:** Este sistema é um filtro FIR (*Finite Impulse Response*) simples de dois coeficientes. É causal porque só olha para o passado, e estável porque a resposta ao impulso tem energia finita.

---

## b) y[n] = x[n + 1]

### Identificação da resposta ao impulso

Aplicando `x[n] = δ[n]`:
```
h[n] = δ[n + 1]
```

Portanto:
```
h[-1] = 1,  h[n] = 0  para n ≠ -1
```

### Causalidade

```
h[-1] = 1 ≠ 0  →  h[n] ≠ 0 para n = -1 < 0  ❌
```

O sistema utiliza a amostra futura `x[n+1]` para calcular a saída em `n`. Isso é fisicamente impossível em sistemas em tempo real.

> **Conclusão: Sistema NÃO CAUSAL ❌**

### Estabilidade BIBO

```
Σ |h[n]| = |h[-1]| = 1 < ∞  ✅
```

> **Conclusão: Sistema ESTÁVEL ✅**

### Resumo

| Propriedade | Resultado |
|---|---|
| Causal | ❌ Não |
| Estável (BIBO) | ✅ Sim |

**Interpretação:** Este sistema é simplesmente um deslocamento temporal da entrada para um instante no futuro. Embora seja matematicamente estável (resposta ao impulso finita), é não causal pois requer conhecimento antecipado da entrada. Pode ser implementado apenas off-line (processamento de dados já gravados).

---

## c) h[n] = (0.5)ⁿ u[n]

A resposta ao impulso já está dada explicitamente.

```
h[n] = (0.5)ⁿ u[n] = { (0.5)ⁿ,  n ≥ 0
                       { 0,       n < 0
```

### Causalidade

```
h[n] = 0  para n < 0  ✅
```

> **Conclusão: Sistema CAUSAL ✅**

### Estabilidade BIBO

```
Σ |h[n]| = Σ (0.5)ⁿ   (n = 0 até +∞)
           = 1 / (1 - 0.5)     [série geométrica com |r| = 0.5 < 1]
           = 1 / 0.5
           = 2 < ∞  ✅
```

> **Conclusão: Sistema ESTÁVEL ✅**

### Resumo

| Propriedade | Resultado |
|---|---|
| Causal | ✅ Sim |
| Estável (BIBO) | ✅ Sim |

**Interpretação:** Este é o sistema IIR (*Infinite Impulse Response*) mais clássico. A base `0.5 < 1` garante que a resposta ao impulso decai exponencialmente, tornando a soma absoluta convergente. O polo do sistema está em `z = 0.5`, dentro do círculo unitário, confirmando a estabilidade.

---

## d) h[n] = 2ⁿ u[n]

```
h[n] = 2ⁿ u[n] = { 2ⁿ,   n ≥ 0
                  { 0,    n < 0
```

### Causalidade

```
h[n] = 0  para n < 0  ✅
```

> **Conclusão: Sistema CAUSAL ✅**

### Estabilidade BIBO

```
Σ |h[n]| = Σ 2ⁿ   (n = 0 até +∞)
```

Como `|2| > 1`, a série geométrica **diverge**:
```
Σ 2ⁿ = 1 + 2 + 4 + 8 + ... → ∞  ❌
```

> **Conclusão: Sistema INSTÁVEL ❌**

**Verificação intuitiva:** Se aplicarmos uma entrada limitada `x[n] = u[n]` (degrau unitário), a saída crescerá sem limite porque cada nova amostra é amplificada por um fator cada vez maior. O polo do sistema está em `z = 2`, **fora** do círculo unitário.

### Resumo

| Propriedade | Resultado |
|---|---|
| Causal | ✅ Sim |
| Estável (BIBO) | ❌ Não |

**Interpretação:** Um sistema com resposta ao impulso crescente (`2ⁿ`) é fisicamente inviável para processamento de sinais em tempo real, pois qualquer perturbação, por menor que seja, será amplificada indefinidamente.

---

## Tabela Comparativa Geral

| Sistema | Expressão | Causal? | Estável? | Justificativa |
|---|---|---|---|---|
| **a** | `y[n] = x[n] + x[n-1]` | ✅ Sim | ✅ Sim | `h[n]=0` para `n<0`; `Σ|h|=2<∞` |
| **b** | `y[n] = x[n+1]` | ❌ Não | ✅ Sim | `h[-1]=1≠0`; `Σ|h|=1<∞` |
| **c** | `h[n] = (0.5)ⁿu[n]` | ✅ Sim | ✅ Sim | `h[n]=0` para `n<0`; `Σ|h|=2<∞` |
| **d** | `h[n] = 2ⁿu[n]` | ✅ Sim | ❌ Não | `h[n]=0` para `n<0`; `Σ|h|→∞` |

---

*Referências: Oppenheim & Schafer (2010); Proakis & Manolakis (2007)*
