# universal turing machine - in ruby

Simulador de Máquina de Turing Universal (MTU) baseado no código de meu professor,
capaz de interpretar e executar máquinas de Turing codificadas em unário.

A MTU lê a codificação das transições concatenadas (via `linker`) seguida da
cadeia de entrada, e simula o comportamento da máquina descrita.

## Linguagens implementadas

- **a\*b\*** — regular, aceita cadeias com zero ou mais `a`s seguidos de zero ou mais `b`s
- **aⁿbⁿ** — livre de contexto, simulada via autômato com pilha codificado na MT
- **aⁿbⁿcⁿ** — sensível ao contexto, usa varreduras sucessivas marcando um triplo (a,b,c) por passagem
