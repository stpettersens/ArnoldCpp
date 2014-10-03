#
#	ArnoldC++ Lexer
#	
#	Based on the  ArnoldC language originally written by Lauri Hartikka,
# 	ArnoldC++ adds support for classes and more data types.
#
# 	@author: Sam Saint-Pettersen, 2014
#
class ArnoldLexer

	STATEMENTS = ["LISTEN TO ME VERY CAREFULLY", "TALK TO THE HAND", "HASTA LA VISTA, BABY",
		"BECAUSE I'M GOING TO SAY PLEASE"]
	KEYWORDS = ["def", "print", "end", "if"]

	def tokenize(code)
		# Cleanup code by removing extra line breaks
		code.chomp!

		# Current character postion
		i = 0

		# Collection of all parsed tokens in the form [:TOKEN_TYPE, value]
		tokens = []

		# Implement a very simple scanner.
		# Scan one character at a time until there is something to parse.
		while i < code.size
			chunk = code[i..-1]

			# Matching standard tokens.
			if identifier = chunk[/\A([A-Z\s\,\'']*)/, 1]

				# Keywords are special identifiers tagged with their own name, 
				# 'if' will result in an [:IF, "if"] token.
				if STATEMENTS.include?(identifier)
					pos = STATEMENTS.index(identifier)
					tokens << [KEYWORDS[pos].upcase.to_sym, identifier]

				# Skip what was just parsed.
				i += identifier.size
				end

			elsif identifier = chunk[/\A([a-z]*)/, 1]
				tokens << [:IDENTIFIER, identifier]
				i += identifier.size

				# Matching class names and constants starting with a capital letter.
			elsif constant = chunk[/\A([A-Z]\w*)/, 1]
				tokens << [:CONSTANT, constant]
				i += constant.size

			elsif newline = chunk[/\A\n/, 1]
				tokens << [:NEWLINE, "\n"]

			elsif number = chunk[/\A([0-9]+)/, 1]
				tokens << [:NUMBER, number.to_i]
				i += number.size

			elsif string = chunk[/\A"(.*?)"/, 1]
				tokens << [:STRING, string]
				i += string.size + 2
			end
		end
		tokens
	end
end
