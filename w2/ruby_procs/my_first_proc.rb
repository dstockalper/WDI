say_hello = Proc.new() do |name|
    Kernel.puts("Greetings, " + name + "!")
end

Kernel.puts(say_hello.inspect())

Kernel.puts("Now trying to invoke proc")
say_hello.call("Max")
