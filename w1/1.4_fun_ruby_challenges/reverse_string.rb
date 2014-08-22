def string_reversal(myString)
	len = myString.length
	mid_point = len / 2
	
	for i in (0...(mid_point))
		opposite_position = len - (i+1)
		temp_front = myString[i]
		temp_back = myString[opposite_position]
		myString[i] = temp_back
		myString[opposite_position] = temp_front
	end

	Kernel.puts(myString)
end


string_reversal("super duper coder")
string_reversal("12345")