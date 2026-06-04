# *comentarios, explicacoes e alguns exemplos gerados por IA!

## Estados
## não-finais: a^{2(i+1)}
q0 = "aa"       # lendo a's, empilhando
q1 = "aaaa"     # lendo b's, desempilhando
## final: a^{2i+1}
q2 = "a"        # aceitação

## Símbolo branco / fim de fita
@branco = "ba"

## ── Alfabeto de entrada ──────────────────────────
## b^{m*3}a  onde m é o índice do símbolo
@sa = "bbba"      # símbolo 'a' de entrada  (índice 1)
@sb = "bbbbbba"   # símbolo 'b' de entrada  (índice 2)

## ── Alfabeto da pilha ────────────────────────────
## Codificado como b^{m*5}a para separar do alfabeto de entrada
@Z  = "ba"          # fundo da pilha  (índice 0 — reutiliza branco)
@pA = "bbbbbbbbbba" # marcador 'A' na pilha (índice 2, base 5)

## ── Operações sobre a pilha ──────────────────────
push_A  = "push:#{@pA}"   # empilha A
pop     = "pop"            # desempilha topo
noop    = "noop"           # mantém pilha intacta

## ── Movimentação do cursor ───────────────────────
esq = "c"
dir = "cc"

## ════════════════════════════════════════════════
## Transições  d(qi, s_entrada, s_pilha) = (qj, op_pilha, movimento)
##
##  d(q0, a, Z) = (q0, push(A),  D)  — 1º 'a': empilha A sobre Z
##  d(q0, a, A) = (q0, push(A),  D)  — 'a' seguinte: empilha A
##  d(q0, b, A) = (q1, pop,      D)  — 1º 'b': desempilha A
##  d(q1, b, A) = (q1, pop,      D)  — 'b' seguinte: desempilha A
##  d(q1, B, Z) = (q2, noop,     E)  — fita vazia, pilha vazia: aceita
## ════════════════════════════════════════════════

@d1 = "#{q0}#{@sa}#{@Z}#{q0}#{push_A}#{dir}"    # d(q0, a, Z) = (q0, push(A), D)
@d2 = "#{q0}#{@sa}#{@pA}#{q0}#{push_A}#{dir}"   # d(q0, a, A) = (q0, push(A), D)
@d3 = "#{q0}#{@sb}#{@pA}#{q1}#{pop}#{dir}"       # d(q0, b, A) = (q1, pop,     D)
@d4 = "#{q1}#{@sb}#{@pA}#{q1}#{pop}#{dir}"       # d(q1, b, A) = (q1, pop,     D)
@d5 = "#{q1}#{@branco}#{@Z}#{q2}#{noop}#{esq}"   # d(q1, B, Z) = (q2, noop,    E)

def linker
  "#{@d1}#{@d2}#{@d3}#{@d4}#{@d5}"
end


#EXEMPLOS
# "aabb"  → aceita  (n=2)
def cadeia_aabb
  "#{@sa}#{@sa}#{@sb}#{@sb}#{@branco}"
end

# "aab" → rejeita (pilha ainda tem A quando fita acaba)
def cadeia_aab_rejeita
  "#{@sa}#{@sa}#{@sb}#{@branco}"
end


# "aaabbb" → aceita  (n=3)
def cadeia_aaabbb
  "#{@sa}#{@sa}#{@sa}#{@sb}#{@sb}#{@sb}#{@branco}"
end

# "ab" → aceita  (n=1)
def cadeia_ab
  "#{@sa}#{@sb}#{@branco}"
end

# "abb" → rejeita  (pilha esvazia antes da fita)
def cadeia_abb_rejeita
  "#{@sa}#{@sb}#{@sb}#{@branco}"
end

# "ba" → rejeita  (começa com 'b', nenhuma transição de q0 com pilha Z lendo b)
def cadeia_ba_rejeita
  "#{@sb}#{@sa}#{@branco}"
end
