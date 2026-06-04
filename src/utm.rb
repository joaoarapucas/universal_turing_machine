class MTU
  attr_accessor :fita, :estado, :cursor, :estado_leitura, :simbolo_leitura, :estado_destino, :simbolo_escrita, :movimento, :transicoes

  def initialize
    @estado = :q1
    @cursor = 0
    @estado = :qi
    @cursor = 0
    @movimento_salvo = :D
  end

  def processar(entrada)
    @fita = "#" + entrada + " " * entrada.size * 3 # fita semi-infinita, virtual
    estado_leitura = ""
    simbolo_leitura = ""
    estado_destino = ""
    simbolo_escrita = ""
    movimento = :D
    transicoes = {}
    @fita_cadeia = []

    while true      
      case [@estado, @fita[@cursor]]

      # iniciar máquina em qi e ir para primeiro estado
      in [:qi, "#"]
        operar("#", :q0, :D)
      # começa a ler a fita e salva em uma estrutura de memória.
      # neste caso, vamos salvar em uma estrutura do Ruby
      in [:q0, "a"] # par: estado não-terminal        
        estado_leitura << "a"
        operar("a", :q1, :D)
      in [:q1, "a"] # ímpar: estado terminal
        estado_leitura << "a"
        operar("a", :q0, :D)
      
      ## Leitura de símbolo de leitura
      in [:q0, "b"] | [:q1, "b"] | [:q2, "b"] # leitura de símbolos
        simbolo_leitura << "b"
        operar("b", :q2, :D)
      in [:q2, "a"] # acabou leitura de símbolos
        simbolo_leitura << "a"
        operar("a", :q4, :D)
      
      # leitura de estado de destino
      in [:q4, "a"] # leitura de estado de destino - par
        estado_destino << "a"
        operar("a", :q5, :D)
      in [:q5, "a"] # leitura de estado de destino - ímpar
        estado_destino << "a"
        operar("a", :q4, :D)
      
      # leitura de símbolo de escrita
      in [:q4, "b"] | [:q5, "b"] | [:q6, "b"] # leitura de símbolos
        simbolo_escrita << "b"
        operar("b", :q6, :D)
      in [:q6, "a"] # acabou leitura de símbolos
        simbolo_escrita << "a"
        operar("a", :q7, :D)

      # Leitura de movimento
      in [:q7, "c"] # esquerda
        movimento = :E
        operar("c", :q8, :D)
      in [:q8, "c"] # direita
        movimento = :D
        operar("c", :q8, :D)

      # reinicia a máquina
      in [:q8, "a"] 
        # direta, salva transição
        leitura = [estado_leitura, simbolo_leitura]
        transicoes[leitura] = [simbolo_escrita, estado_destino, movimento]
        puts("Transição lida: (#{estado_leitura},#{simbolo_leitura})->(#{simbolo_escrita},#{estado_destino},#{movimento})")
        
        estado_leitura = "a"
        simbolo_leitura = ""
        estado_destino = ""
        simbolo_escrita = ""

        operar("a", :q1, :D)

      ######### leitura dos símbolos de w ##########   
      # começa a leitura dos símbolos e processamento de w
      in [:q8, "$"]
        # adiciona o último estado
        leitura = [estado_leitura, simbolo_leitura]
        transicoes[leitura] = [simbolo_escrita, estado_destino, movimento]
        puts("Transição lida: (#{estado_leitura},#{simbolo_leitura})->(#{simbolo_escrita},#{estado_destino},#{movimento})")
        puts("============================\n\n")
        puts("Enter para continuar...")
        puts("============================\n\n")
        gets
        puts("=========== Leitura dos símbolos: ===========")
        operar("$", :q20, :D)
        simbolo_leitura = ""
      in [:q20, 'b']
        simbolo_leitura << "b"
        operar("b", :q20, :D)
      in [:q20, 'a']
        simbolo_leitura << "a"
        operar("a", :q21, :D)
      
      in [:q21, 'b'] # recomeça a leitura
        @fita_cadeia << simbolo_leitura

        # reinicia a leitura dos símbolos
        simbolo_leitura = "b"
        operar("b", :q20, :D)
        
      in [:q21, ' '] # finaliza leitura
        @fita_cadeia << simbolo_leitura
        
        puts("=========== Fita de símbolos: ===========\n")
        print(@fita_cadeia)
        
        ######## iniciando a leitura de w
        return submaquina(transicoes)
      else
        puts "(#{estado_leitura},#{simbolo_leitura}) = (#{estado_destino},#{simbolo_escrita},#{movimento})"
        return false
      end
    end
  end

  def submaquina(transicoes)
    # estado inicial da máquina a ser simulada
    estado_mt = "aa"
    @cursor_leitura = 0

    while true
      simbolo_leitura = @fita_cadeia[@cursor_leitura]

      leitura = [estado_mt, simbolo_leitura]
      puts "(#{estado_mt}, #{simbolo_leitura})"
      resultado = transicoes[leitura]

      if resultado.nil? #caso n tenha transicao retorna falso (evita quebrar o programa)
        puts "\n=========================================="
        puts "sem transicao para (#{estado_mt}, #{simbolo_leitura})"
        puts "maquina travada -> REJEITA"
        puts "==========================================\n\n"
        return false
      end
      
      simbolo_escrita = resultado[0]
      estado_destino = resultado[1]
      movimento = resultado[2]
      puts "-> (#{estado_destino},#{simbolo_escrita},#{movimento})"

      estado_mt = estado_destino
      @fita_cadeia[@cursor_leitura] = simbolo_escrita

      if (simbolo_leitura == "ba")
        puts "\n=========================================="
        puts "Finalizando a leitura na máquina principal"
        puts "Estado final da máquina: #{estado_mt}"
        puts "==========================================\n\n"
        if (estado_mt.size % 2 == 1) # impar, aceitação
          return true
        else
          return false
        end
      end

      if movimento == :D
        @cursor_leitura += 1
      else
        @cursor_leitura -= 1
      end
    end
  end

  def operar(escrever, estado, movimento = :D)
    @fita[@cursor] = escrever
    @estado = estado
    if movimento == :D
      @cursor += 1
    else
      @cursor -= 1
    end
  end

  def fita
    @fita_cadeia
  end

  def cursor
    @cursor
  end
end
