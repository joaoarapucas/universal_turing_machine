# *comentarios, explicacoes e alguns exemplos gerados por IA!

## ═══════════════════════════════════════════════════════
## Máquina de Turing para a^n b^n c^n  (sensível ao contexto)
## Estratégia: varreduras sucessivas marcando um a, um b, um c
##             por passagem. Aceita quando tudo estiver marcado.
## ═══════════════════════════════════════════════════════

## ── Estados ──────────────────────────────────────────
## não-finais: a^{2(i+1)}
q0 = "aa"           # início de varredura: busca 'a' não marcado
q1 = "aaaa"         # achou 'a', busca 'b' não marcado (→ direita)
q2 = "aaaaaa"       # achou 'b', busca 'c' não marcado (→ direita)
q3 = "aaaaaaaa"     # achou 'c', volta ao início (← esquerda)
q4 = "aaaaaaaaaa"   # verifica: não pode restar b ou c desmarcado
## final: a^{2i+1}
q5 = "a"            # aceitação

## ── Fita ─────────────────────────────────────────────
@branco = "ba"      # B: fim de fita (índice 0)

## ── Alfabeto de entrada  b^{m*3}a ────────────────────
@sa = "bbba"        # 'a'  (índice 1)
@sb = "bbbbbba"     # 'b'  (índice 2)
@sc = "bbbbbbbbbba" # 'c'  (índice 3)

## ── Símbolos de marcação  b^{m*3}a (continuando índices) ──
@sx = "bbbbbbbbbbbbbba"   # 'X': marca 'a' já processado (índice 4)
@sy = "bbbbbbbbbbbbbbbbbba" # 'Y': marca 'b' já processado (índice 5)
@sz = "bbbbbbbbbbbbbbbbbbbbbba" # 'Z': marca 'c' já processado (índice 6)

## ── Movimentação ─────────────────────────────────────
esq = "c"
dir = "cc"

## ════════════════════════════════════════════════════
## Transições
##
## FASE 1 — q0: início de cada varredura
##   d(q0, X) = (q0, X, D)   pula X já marcados
##   d(q0, a) = (q1, X, D)   marca 'a' → X, vai buscar 'b'
##   d(q0, Y) = (q4, Y, D)   não há mais 'a': verifica resto
##
## FASE 2 — q1: busca 'b' não marcado
##   d(q1, a) = (q1, a, D)   pula 'a's restantes
##   d(q1, Y) = (q1, Y, D)   pula Y já marcados
##   d(q1, b) = (q2, Y, D)   marca 'b' → Y, vai buscar 'c'
##
## FASE 3 — q2: busca 'c' não marcado
##   d(q2, b) = (q2, b, D)   pula 'b's restantes
##   d(q2, Z) = (q2, Z, D)   pula Z já marcados
##   d(q2, c) = (q3, Z, E)   marca 'c' → Z, volta ao início
##
## FASE 4 — q3: volta ao início
##   d(q3, Z) = (q3, Z, E)
##   d(q3, b) = (q3, b, E)
##   d(q3, Y) = (q3, Y, E)
##   d(q3, a) = (q3, a, E)
##   d(q3, X) = (q0, X, D)   achou início → nova varredura
##
## FASE 5 — q4: verificação final
##   d(q4, Y) = (q4, Y, D)   pula Y (b's marcados): ok
##   d(q4, Z) = (q4, Z, D)   pula Z (c's marcados): ok
##   d(q4, B) = (q5, B, E)   fim de fita limpo → aceita
##   (se encontrar 'b' ou 'c' desmarcado → trava, rejeita)
## ════════════════════════════════════════════════════

## — Fase 1: q0 varre início ——————————————————————————
@d01 = "#{q0}#{@sx}#{q0}#{@sx}#{dir}"    # d(q0, X) = (q0, X, D)
@d02 = "#{q0}#{@sa}#{q1}#{@sx}#{dir}"    # d(q0, a) = (q1, X, D)
@d03 = "#{q0}#{@sy}#{q4}#{@sy}#{dir}"    # d(q0, Y) = (q4, Y, D) — sem 'a': verifica

## — Fase 2: q1 busca 'b' ————————————————————————————
@d11 = "#{q1}#{@sa}#{q1}#{@sa}#{dir}"    # d(q1, a) = (q1, a, D)
@d12 = "#{q1}#{@sy}#{q1}#{@sy}#{dir}"    # d(q1, Y) = (q1, Y, D)
@d13 = "#{q1}#{@sb}#{q2}#{@sy}#{dir}"    # d(q1, b) = (q2, Y, D)

## — Fase 3: q2 busca 'c' ————————————————————————————
@d21 = "#{q2}#{@sb}#{q2}#{@sb}#{dir}"    # d(q2, b) = (q2, b, D)
@d22 = "#{q2}#{@sz}#{q2}#{@sz}#{dir}"    # d(q2, Z) = (q2, Z, D)
@d23 = "#{q2}#{@sc}#{q3}#{@sz}#{esq}"    # d(q2, c) = (q3, Z, E)

## — Fase 4: q3 volta ao início ——————————————————————
@d31 = "#{q3}#{@sz}#{q3}#{@sz}#{esq}"    # d(q3, Z) = (q3, Z, E)
@d32 = "#{q3}#{@sb}#{q3}#{@sb}#{esq}"    # d(q3, b) = (q3, b, E)
@d33 = "#{q3}#{@sy}#{q3}#{@sy}#{esq}"    # d(q3, Y) = (q3, Y, E)
@d34 = "#{q3}#{@sa}#{q3}#{@sa}#{esq}"    # d(q3, a) = (q3, a, E)
@d35 = "#{q3}#{@sx}#{q0}#{@sx}#{dir}"    # d(q3, X) = (q0, X, D) — reinicia

## — Fase 5: q4 verificação final ————————————————————
@d41 = "#{q4}#{@sy}#{q4}#{@sy}#{dir}"    # d(q4, Y) = (q4, Y, D)
@d42 = "#{q4}#{@sz}#{q4}#{@sz}#{dir}"    # d(q4, Z) = (q4, Z, D)
@d43 = "#{q4}#{@branco}#{q5}#{@branco}#{esq}" # d(q4, B) = (q5, B, E) — aceita!

def linker
  "#{@d01}#{@d02}#{@d03}" \
  "#{@d11}#{@d12}#{@d13}" \
  "#{@d21}#{@d22}#{@d23}" \
  "#{@d31}#{@d32}#{@d33}#{@d34}#{@d35}" \
  "#{@d41}#{@d42}#{@d43}"
end

## ════════════════════════════════════════════════════
## Codificações de cadeias de teste
## ════════════════════════════════════════════════════

# "abc"    → aceita (n=1)
def cadeia_abc
  "#{@sa}#{@sb}#{@sc}#{@branco}"
end

# "aabbc"  → rejeita (2a, 2b, 1c)
def cadeia_rejeita_aabbc
  "#{@sa}#{@sa}#{@sb}#{@sb}#{@sc}#{@branco}"
end


# "aabbcc" → aceita (n=2)
def cadeia_aabbcc
  "#{@sa}#{@sa}#{@sb}#{@sb}#{@sc}#{@sc}#{@branco}"
end

# "aaabbbccc" → aceita (n=3)
def cadeia_aaabbbccc
  "#{@sa}#{@sa}#{@sa}#{@sb}#{@sb}#{@sb}#{@sc}#{@sc}#{@sc}#{@branco}"
end

# "aabcc"  → rejeita (2a, 1b, 2c) — trava na fase 2 (não acha 'b' suficiente)
def cadeia_rejeita_aabcc
  "#{@sa}#{@sa}#{@sb}#{@sc}#{@sc}#{@branco}"
end

# "abbc"   → rejeita (1a, 2b, 1c) — trava na fase 5 (sobra Y)
def cadeia_rejeita_abbc
  "#{@sa}#{@sb}#{@sb}#{@sc}#{@branco}"
end
