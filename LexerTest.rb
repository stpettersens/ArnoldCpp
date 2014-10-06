require "ArnoldLexer"

code =<<-EOS
LISTEN TO ME VERY CAREFULLY
EOS
#TALK TO THE HAND "Hello World!"
#HASTA LA VISTA, BABY


p ArnoldLexer.new.tokenize(code)
