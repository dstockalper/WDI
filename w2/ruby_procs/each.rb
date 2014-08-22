def each(list_of_items, thing_to_do)
    for item in list_of_items
        thing_to_do.call(item)
    end
end

drink_soda = Proc.new() do |drink|
    Kernel.puts("Chugging a fizzy " + drink)
end

sip_soda = Proc.new() do |drink|
    Kernel.puts("Daintily sipping a " + drink)
end

drinks = ['Coca-Cola', 'Dr. Pepper', 'Sarsaparilla']

each(drinks, sip_soda)
each(drinks, drink_soda)
