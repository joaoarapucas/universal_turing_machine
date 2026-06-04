## estados não finais
## a^{2(i+1)}
q0 = "aa"
q1 = "aaaa"
## estados finais
## a^{2i + 1}
q2 = "a"
# símbolo branco
@b = "ba"
## elementos do alfabeto
## sigma = {s0, s1, ..., sn}
## b^{m*3}a
@sa = "bbba"       # símbolo 'a' da fita
@sb = "bbbbbba"    # símbolo 'b' da fita
## movimentacao do cursor
esq = "c"
dir = "cc"

# Transições da MT que aceita a*b*
#
# d(q0, a) = (q0, a, D) - continua lendo 'a's
# d(q0, b) = (q1, b, D) - primeiro 'b' encontrado, vai para q1
# d(q0, B) = (q2, B, E) - fita vazia ou só 'a's -> aceita
# d(q1, b) = (q1, b, D) - continua lendo 'b's
# d(q1, B) = (q2, B, E) - fim dos 'b's -> aceita

@d1 = "#{q0}#{@sa}#{q0}#{@sa}#{dir}"   # d(q0, a) = (q0, a, D)
@d2 = "#{q0}#{@sb}#{q1}#{@sb}#{dir}"   # d(q0, b) = (q1, b, D)
@d3 = "#{q0}#{@b}#{q2}#{@b}#{esq}"     # d(q0, B) = (q2, B, E)
@d4 = "#{q1}#{@sb}#{q1}#{@sb}#{dir}"   # d(q1, b) = (q1, b, D)
@d5 = "#{q1}#{@b}#{q2}#{@b}#{esq}"     # d(q1, B) = (q2, B, E)

def linker
  "#{@d1}#{@d2}#{@d3}#{@d4}#{@d5}"
end

#EXEMPLOS
def codificacao_cadeia_aceita_aabb
  "#{@sa}#{@sa}#{@sb}#{@sb}#{@b}"    # "aabb" -> aceita
end

def codificacao_cadeia_rejeita
  "#{@sa}#{@sb}#{@sa}#{@b}"         # "aba"  -> rejeita
end

def codificacao_cadeia_aceita_so_a
  "#{@sa}#{@sa}#{@sa}#{@b}"          # "aaa"  → aceita
end

def codificacao_cadeia_aceita_so_b
  "#{@sb}#{@sb}#{@b}"                # "bb"   → aceita
end

def codificacao_cadeia_aceita_vazia
  "#{@b}"                            # ""     → aceita
end

