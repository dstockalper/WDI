Kernel.puts("Type '1' to convert from Celcius go Farenheit
	OR Type '2' to convert form Farenheit to Celcius")

user_choice = Kernel.gets().chomp().to_i()

if (user_choice == 1)
	Kernel.puts("Enter Celcius temperature: ")
	cel = Kernel.gets().chomp().to_f.round(2)
	far = (32 + ((cel*9.0)/5.0)).to_f().round(2)
	Kernel.puts("#{cel.to_s()} degrees Celcius is equal to #{far.to_s()} degrees Farenheit.")
elsif (user_choice == 2)
	Kernel.puts("Enter Farenheit temperature: ")
	far = Kernel.gets().chomp().to_f.round(2)
	cel = (((far-32)*5.0)/9).to_f().round(2)
	Kernel.puts("#{far.to_s()} degrees Farenheit is equal to #{cel.to_s()} degrees Celcius.")
else
	Kernel.puts("You must enter a '1' or '2'.")
end
