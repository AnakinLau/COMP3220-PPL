load "TinyToken.rb"
load "TinyScanner.rb"

# filename.txt below is simply the "source code"
# that you write that adheres to your grammar rules
# if it is in the same directory as this file, you can
# simply include the file name, otherwise, you will need
# to specify the entire path to the file as we did above
# to load the other ruby modules
if(ARGV[0] != nil)
	@path = ARGV[0]
	@writePath = "parsedResult.txt"
	if(ARGV[1] != nil)
		@writePath = ARGV[1]
	end
	if File.exist?(@path)
		scan = Scanner.new(@path)
		#Creates new txt file
		fileOutput = ""	
		tok = scan.nextToken()
		while (tok.get_type() != Token::EOF)

		fileOutput += "Token: #{tok} type: #{tok.get_type()}" + "\n" 
		puts "Token: #{tok} Type: #{tok.get_type()}"
		tok = scan.nextToken()
		end 
		fileOutput += "Token: #{tok} type: #{tok.get_type()}"
		puts "Token: #{tok} Type: #{tok.get_type()}"
		File.write(@writePath, fileOutput)
		puts "Your results have been written to " + @writePath + "!"
		puts "You can also specify output location and name with a second console argument."
	else
		puts "File Path Not Found. Please try again with correct file path."

	end
else
	puts "Please enter file path as argument. And desire output file name as second argument." 
end