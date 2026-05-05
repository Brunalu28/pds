# Atividade 3 – Sistema Descrito por Equação de Diferenças
---

## Sistema analisado

```
y[n] = 0.8 · y[n-1] + x[n]
```

**Condição inicial:** `y[n] = 0` para `n < 0`  
**Entrada:** `x[n] = δ[n]` (impulso unitário discreto)

Lembrando que:
```
δ[n] = 1,  se n = 0
δ[n] = 0,  se n ≠ 0
```

---

## 1) Primeiros valores de h[n] para 0 ≤ n ≤ 5

Como a entrada é o impulso `δ[n]`, a saída será a resposta ao impulso `h[n]`.

**n = 0:**
```
h[0] = 0.8 · h[-1] + δ[0]
     = 0.8 · 0 + 1
     = 1
```

**n = 1:**
```
h[1] = 0.8 · h[0] + δ[1]
     = 0.8 · 1 + 0
     = 0.8
```

**n = 2:**
```
h[2] = 0.8 · h[1] + δ[2]
     = 0.8 · 0.8 + 0
     = 0.64
```

**n = 3:**
```
h[3] = 0.8 · h[2] + δ[3]
     = 0.8 · 0.64 + 0
     = 0.512
```

**n = 4:**
```
h[4] = 0.8 · h[3] + δ[4]
     = 0.8 · 0.512 + 0
     = 0.4096
```

**n = 5:**
```
h[5] = 0.8 · h[4] + δ[5]
     = 0.8 · 0.4096 + 0
     = 0.32768
```

---

### Tabela resumo

| n | h[n] | Valor aproximado |
|---|------|-----------------|
| 0 | (0.8)⁰ = 1 | 1.000000 |
| 1 | (0.8)¹ | 0.800000 |
| 2 | (0.8)² | 0.640000 |
| 3 | (0.8)³ | 0.512000 |
| 4 | (0.8)⁴ | 0.409600 |
| 5 | (0.8)⁵ | 0.327680 |

**Forma geral:**
```
h[n] = (0.8)ⁿ · u[n]
```
onde `u[n]` é o degrau unitário discreto.

---

### Visualização gráfica (ASCII)

```
h[n]
1.0 | *
0.8 |    *
0.6 |       *
0.5 |
0.4 |          *  *
0.3 |                *
    +--+----+----+----+----+----+--- n
       0    1    2    3    4    5
```

---

## 2) Análise de estabilidade

A forma geral da resposta ao impulso é `h[n] = (0.8)ⁿ u[n]`.

Para verificar a estabilidade BIBO, calculamos a soma absoluta:

```
Σ |h[n]| = Σ (0.8)ⁿ   (para n = 0 até +∞)
           = 1 / (1 - 0.8)
           = 1 / 0.2
           = 5
```

Como `|0.8| < 1`, a série geométrica converge para um valor finito (5).

**Portanto, a condição de estabilidade BIBO é satisfeita:**

```
Σ |h[n]| = 5 < ∞  ✓
```

> **Conclusão:** O sistema é **estável**. Qualquer entrada de amplitude limitada produzirá uma saída de amplitude limitada. Isso é esperado, pois o polo do sistema está em `z = 0.8`, dentro do círculo unitário.

---

## 3) Causalidade do sistema

Um sistema LTI é causal se e somente se:
```
h[n] = 0  para todo  n < 0
```

Da tabela e da forma geral `h[n] = (0.8)ⁿ u[n]`, observamos:

- Para `n < 0`: `u[n] = 0`, portanto `h[n] = 0` ✓
- Para `n ≥ 0`: `h[n] = (0.8)ⁿ ≠ 0` (somente valores presentes e passados influenciam a saída)

Além disso, a própria equação de diferenças confirma a causalidade:

```
y[n] = 0.8 · y[n-1] + x[n]
```

A saída em `n` depende apenas de `y[n-1]` (passado) e `x[n]` (presente), **nunca de valores futuros**.

> **Conclusão:** O sistema é **causal** ✓

---

## Resumo

| Propriedade | Resultado | Justificativa |
|---|---|---|
| **Estabilidade BIBO** | ✅ Estável | `Σ|h[n]| = 5 < ∞` (polo em z=0.8 dentro do círculo unitário) |
| **Causalidade** | ✅ Causal | `h[n] = 0` para `n < 0`; saída depende apenas de passado e presente |

---

*Referências: Oppenheim & Schafer (2010); Proakis & Manolakis (2007)*
