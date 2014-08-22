
require 'pry'

def multiply(x, y)
      binding.pry
      Kernel.puts(“After the binding.pry”)
      return (x * y)
end

multiply(10, 43)
