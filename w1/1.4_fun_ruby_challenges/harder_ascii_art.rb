def acii_artify(input_string)

	alphabet =
	{
		"a" => [
		 	'    /\     ',
		 	'   /  \    ',
		 	'  /____\   ',
		 	' /      \  ',
		 	'/        \ '
	 	],

		"b" => [
		 	'_______  ',
		 	'|      \ ',
		 	'|______/ ',
		 	'|      \ ',
		 	'|______/ '
	 	], 

		"c" => [
		 	'  _____ ',
		 	' /      ',
		 	'|       ',
		 	'|       ',
		 	' \_____ '
		 ],  

		 "d" => [
		 	'______   ',
		 	'|     \  ',
		 	'|      | ',
		 	'|      | ',
		 	'|_____/  '
		 ],  

		 "e" => [
		 	'_______  ',
		 	'|        ',
		 	'|____    ',
		 	'|        ',
		 	'|______  '
		 ],  

		"f" => [
		 	'_______ ',
		 	'|       ',
		 	'|____   ',
		 	'|       ',
		 	'|       '
		 ],  

		 "g" => [
		 	' ______  ',
		 	'/      \ ',
		 	'|   ____ ',
		 	'|      \ ',
		 	'\______/ '
		 ],  

		 "h" => [
		 	'         ',
		 	'|      | ',
		 	'|______| ',
		 	'|      | ',
		 	'|      | '
		 ],  

		 "i" => [
		 	'_______ ',
		 	'   |    ',
		 	'   |    ',
		 	'   |    ',
		 	'___|___ '
		 ],  

		"j" => [
		 	'________ ',
		 	'     |   ',
		 	'     |   ',
		 	'|    /   ',
		 	' \__/    '
	 	],

	 	"k" => [
		 	'|    / ',
		 	'|  /   ',
		 	'|/     ',
		 	'|  \   ',
		 	'|    \ '
	 	],

	 	"l" => [
		 	'       ',
		 	'|      ',
		 	'|      ',
		 	'|      ',
		 	'|____| '
	 	],

	 	"m" => [
		 	'|\    /| ',
		 	'| \  / | ',
		 	'|  \/  | ',
		 	'|      | ',
		 	'|      | '
	 	],

	 	"n" => [
		 	'|\     | ',
		 	'| \    | ',
		 	'|  \   | ',
		 	'|    \ | ',
		 	'|     \| '
	 	],

	 	"o" => [
		 	'  _____  ',
		 	' /     \ ',
		 	'|       |',
		 	'|       |',
		 	' \_____/ '
	 	],

	 	"p" => [
		 	' _____  ',
		 	'|     \ ',
		 	'|_____/ ',
		 	'|       ',
		 	'|       '
	 	],

	 	"q" => [
		 	'  ___   ',
		 	' /   \  ',
		 	'|     | ',
		 	'|    \| ',
		 	' \___/\ '
	 	],

	 	"r" => [
		 	' _____  ',
		 	'|     \ ',
		 	'|_____/ ',
		 	'|   \   ',
		 	'|    \  '
	 	],

	 	"s" => [
		 	' _____  ',
		 	'/     \ ',
		 	'\_____  ',
		 	'      \ ',
		 	'\_____/ '
	 	],


		 "t" => [
		 	'_______ ',
		 	'   |    ',
		 	'   |    ',
		 	'   |    ',
		 	'   |    '
		 ],  

		 "u" => [
		 	'         ',
		 	'|      | ',
		 	'|      | ',
		 	'|      | ',
		 	' \____/| '
	 	],

		 "v" => [
		 	'         ',
		 	'\      / ',
		 	' \    /  ',
		 	'  \  /   ',
		 	'   \/    '
	 	],

	 	 "w" => [
		 	'         ',
		 	'|      | ',
		 	'\      / ',
		 	' \  | /  ',
		 	'  \/\/   '
	 	],

	 	"x" => [
		 	'        ',
		 	'\     / ',
		 	'  \ /   ',
		 	'  / \   ',
		 	'/     \ '
	 	],

	 	"y" => [
		 	'        ',
		 	'\     / ',
		 	'  \ /   ',
		 	'   |    ',
		 	'   |    '
	 	],

	 	"z" => [
		 	' _____ ',
		 	'     / ',
		 	'    /  ',
		 	'  /    ',
		 	' /____ '
		 ]
	}

	# Take input string, and place letters as elements in array
	arr = input_string.downcase().split("")
	# Initialize rows
	row0 = ""
	row1 = ""
	row2 = ""
	row3 = ""
	row4 = ""

	# Build word/sentence row by row (i.e. top of all letters, then middle of all letters, then bottom of all letterss)
	for letter in arr
		row0 += alphabet[letter][0]
		row1 += alphabet[letter][1]
		row2 += alphabet[letter][2]
		row3 += alphabet[letter][3]
		row4 += alphabet[letter][4]
	end

	# Print out the built rows
	Kernel.puts(row0, row1, row2, row3, row4)
end
 
acii_artify("ABCDEFGHI")
acii_artify("JKLMNOPQR")
acii_artify("STUVWXYZ")
acii_artify("doug")



