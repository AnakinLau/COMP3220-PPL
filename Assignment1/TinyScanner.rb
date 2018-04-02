# https://www.cs.rochester.edu/~brown/173/readings/05_grammars.txt
#
#  "TINY" Grammar
#
# PGM        -->   STMT+
# STMT       -->   ASSIGN   |   "print"  EXP                           
# ASSIGN     -->   ID  "="  EXP
# EXP        -->   TERM   ETAIL
# ETAIL      -->   "+" TERM   ETAIL  | "-" TERM   ETAIL | EPSILON
# TERM       -->   FACTOR  TTAIL
# TTAIL      -->   "*" FACTOR TTAIL  | "/" FACTOR TTAIL | EPSILON
# FACTOR     -->   "(" EXP ")" | INT | ID   
#                  
# ID         -->   ALPHA+
# ALPHA      -->   a  |  b  | … | z  or 
#                  A  |  B  | … | Z
# INT        -->   DIGIT+
# DIGIT      -->   0  |  1  | …  |  9
# WHITESPACE -->   Ruby Whitespace

#
#  Class Scanner - Reads a TINY program and emits tokens
#
class Scanner 
# Constructor - Is passed a file to scan and outputs a token
#               each time nextToken() is invoked.
#   @c        - A one character lookahead 
	def initialize(filename)
		
		if(!File.exist?(filename))
			puts "The File Does Not Exist"
			exit
		
		else
			@f = File.open(filename,'r:utf-8')
		
			if (! @f.eof?)
				@c = @f.getc()
			else
				@c = "!eof!"
				@f.close()
			end
		end
	end
	
	# Method nextCh() returns the next character in the file
	def nextCh()
		if (! @f.eof?)
			@c = @f.getc()
		else
			@c = "!eof!"
		end
		
		return @c
	end

	# Method nextToken() reads characters in the file and returns
	# the next token
	def nextToken() 
		if @c == "!eof!"
			return Token.new(Token::EOF,"eof")
				
		elsif (whitespace?(@c))
			str =""
		
			while whitespace?(@c)
				str += @c
				nextCh()
			end
		
			tok = Token.new(Token::WS,str)
			return tok
			
		elsif (letter?(@c))
			str = ""
			
			while letter?(@c)
				str += @c
				nextCh()
			end
			
			if(str == "print") 
				tok = Token.new(Token::PRINT,str)
				return tok
			end 
			
			tok = Token.new(Token::ID,str)
			return tok
			
		elsif (numeric?(@c))
			str = ""
			
			while numeric?(@c)
				str += @c
				nextCh()
			end
			
			tok = Token.new(Token::INT,str)
			return tok
			
		elsif (@c == "=")
		    nextCh()
			return Token.new(Token::EQUAL, "=")
			
		elsif (@c == "+")
			nextCh()
			return Token.new(Token::ADDOP, "+")
		
		elsif (@c == "-")
			nextCh()
			return Token.new(Token::SUBOP, "-")
		
		elsif (@c == "(")
			nextCh()
			return Token.new(Token::LPAREN, "(")
			
		elsif (@c == ")")
			nextCh()
			return Token.new(Token::RPAREN, ")")
			
		elsif (@c == "*")
		    nextCh()
			return Token.new(Token::MULOP, "*")
			
		elsif (@c == "/")
			nextCh()
			return Token.new(Token::DIVOP, "/")	
		# elsif ...
		# more code needed here! complete the code here 
		# so that your scanner can correctly recognize
		# and print or display all tokens in our grammar
		
		# don't want to give back nil token!
		# remember to include some case to handle
		# unknown or unrecognized tokens.
		else 
			unknownTok = @c
			nextCh()
			tok = Token.new(Token::UNKNOWN,unknownTok)
		end
	end
	
end
#
# Helper methods for Scanner
#
def letter?(lookAhead)
	lookAhead =~ /^[a-z]|[A-Z]$/
end

def numeric?(lookAhead)
	lookAhead =~ /^(\d)+$/
end

def whitespace?(lookAhead)
	lookAhead =~ /^(\s)+$/
end
