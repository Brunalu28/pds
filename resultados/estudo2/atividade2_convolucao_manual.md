# Atividade 2 – Cálculo Manual de Convolução

---

## Dados do problema

```
x[n] = {1, 2, 1}   →   x[0]=1, x[1]=2, x[2]=1
h[n] = {1, 1}       →   h[0]=1, h[1]=1
```

Ambas as sequências começam em `n = 0`.

---

## 1) Cálculo manual da convolução y[n] = x[n] * h[n]

A fórmula da convolução discreta é:

```
y[n] = Σ x[k] · h[n - k]
```

O comprimento da saída será `L = len(x) + len(h) - 1 = 3 + 2 - 1 = 4` amostras.

---

### Cálculo amostra a amostra

**y[0]:**
```
y[0] = x[0]·h[0] + x[1]·h[-1] + x[2]·h[-2]
     = 1·1 + 2·0 + 1·0
     = 1
```
*(h[n] = 0 para n < 0)*

**y[1]:**
```
y[1] = x[0]·h[1] + x[1]·h[0] + x[2]·h[-1]
     = 1·1 + 2·1 + 1·0
     = 1 + 2
     = 3
```

**y[2]:**
```
y[2] = x[0]·h[2] + x[1]·h[1] + x[2]·h[0]
     = 1·0 + 2·1 + 1·1
     = 0 + 2 + 1
     = 3
```

**y[3]:**
```
y[3] = x[0]·h[3] + x[1]·h[2] + x[2]·h[1]
     = 1·0 + 2·0 + 1·1
     = 1
```

---

### Método alternativo: "tabela de multiplicações"

Pode-se visualizar a convolução como uma multiplicação polinomial:

```
x[n] ↔ 1 + 2z⁻¹ + 1z⁻²
h[n] ↔ 1 + 1z⁻¹

Multiplicando:
  (1 + 2z⁻¹ + z⁻²)(1 + z⁻¹)
= 1 + z⁻¹ + 2z⁻¹ + 2z⁻² + z⁻² + z⁻³
= 1 + 3z⁻¹ + 3z⁻² + z⁻³
```

Confirmando: coeficientes `{1, 3, 3, 1}`.

---

## 2) Resultado em forma de sequência

```
y[n] = {1, 3, 3, 1}

n  |  0  |  1  |  2  |  3
y  |  1  |  3  |  3  |  1
```

Representação gráfica (ASCII):

```
y[n]
  3 |    *     *
  2 |
  1 | *              *
  0 +--+----+----+----+--- n
     0    1    2    3
```

---

## 3) Significado do resultado obtido

O sinal de saída `y[n] = {1, 3, 3, 1}` representa o efeito do sistema (com resposta ao impulso `h[n] = {1, 1}`) sobre a entrada `x[n] = {1, 2, 1}`.

**Interpretação física:**

- O filtro `h[n] = {1, 1}` é um **somador de duas amostras consecutivas**: `y[n] = x[n] + x[n-1]`. Ele acumula a amostra atual com a anterior.

- A saída apresenta **alargamento temporal**: enquanto a entrada tem 3 amostras, a saída tem 4 — a convolução sempre resulta em um sinal mais longo, refletindo a "memória" introduzida pelo sistema.

- O valor máximo da saída (`y[1] = y[2] = 3`) ocorre justamente onde a sobreposição entre `x[n]` e `h[n]` é mais intensa.

- Os valores `1` nas extremidades (`y[0]` e `y[3]`) correspondem aos momentos de entrada e saída do sinal pelo sistema, onde apenas uma amostra contribui para a soma.

**Em síntese:** a convolução com `h[n] = {1, 1}` realiza uma operação de **acumulação** das amostras adjacentes de `x[n]`, resultando em um sinal suavemente alargado e com maior energia total.

---

*Referências: Oppenheim & Schafer (2010); Proakis & Manolakis (2007)*
