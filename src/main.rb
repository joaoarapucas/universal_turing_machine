require_relative 'utm'
require_relative 'languages/regular_language'
require_relative 'languages/context_free_language'
require_relative 'languages/context_sensitive_language'


#-----  linguagem regular -----
puts "LINGUAGEM REGULAR"

#ACEITA
entrada = linker + "$" + codificacao_cadeia_aceita_aabb
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""

#REJEITA
entrada = linker + "$" + codificacao_cadeia_rejeita
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""


#----- linguagem livre de contexto -----
puts "LINGUAGEM LIVRE DE CONTEXTO"

#ACEITA
entrada = linker + "$" + cadeia_aaabbb
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""

#REJEITA
entrada = linker + "$" + cadeia_aab_rejeita
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""


#----- linguagem sensivel a contexto -----
puts "LINGUAGEM SENSIVEL A CONTEXTO"

#ACEITA
entrada = linker + "$" + cadeia_aabbcc
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""

#REJEITA
entrada = linker + "$" + cadeia_rejeita_aabbc
mt = MTU.new

puts "Entrada:\n #{entrada}"
puts "Decidiu? #{mt.processar(entrada)}"
puts "Fita Resultante:\n #{mt.fita}"
puts "Cursor parou em #{mt.cursor}"
puts "Cursor no estado #{mt.estado}"
puts "Cursor está lendo \"#{mt.fita[mt.cursor]}\""
