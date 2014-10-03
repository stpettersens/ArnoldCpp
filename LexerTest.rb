require "ArnoldLexer"

code =<<-EOS
myMethod
EOS
#TALK TO THE HAND "Hello World!"
#HASTA LA VISTA, BABY


p ArnoldLexer.new.tokenize(code)
