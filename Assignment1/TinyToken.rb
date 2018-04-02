#
#  Class Token - Encapsulates the tokens in TINY
#
#   @type - the type of token
#   @text - the text the token represents
#
class Token
	attr_accessor :type
	attr_accessor :text

	EOF = "eof"
	LPAREN = "("
	RPAREN = ")"
	ADDOP  = "+"
	SUBOP  = "-"
	MULOP  = "*"
	DIVOP  = "/"
	EQUAL  = "="
	WS     = "whitespace"
	ID     = "ID"
	INT    = "INT"
	PRINT  = "PRINT"
	#Below is also Unkown
	UNKNOWN  = "Unknown"
	
	
#add the rest of the tokens needed based on the grammar
#specified in the Scanner class "TinyScanner.rb"

	def initialize(type,text)
		@type = type
		@text = text
	end
	
	def get_type
		return @type
	end
	
	def get_text
		return @text
	end
	
	def to_s
	# return "[Type: #{@type} || Text: #{@text}]"
		return "#{@text}"
	end
end
