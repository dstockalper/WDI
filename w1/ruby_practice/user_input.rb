def conversion(order)
	Kernel.print("User, enter your #{order} number: ")
	user_input = Kernel.gets().chomp().to_i()
end

first = conversion("first")
second = conversion("second")
sum = first + second

Kernel.print("Your total: ", 
	first.to_s() + ' + ' + second.to_s() + ' = ' + sum.to_s(),
	"\n \n")