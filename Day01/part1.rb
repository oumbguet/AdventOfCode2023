require '../utils/get_input.rb'

data = get_input(1).split("\n")

def get_numbers(str)
    numbers = str.scan(/[0-9]/).join()
    return "%d%d" % [numbers[0], numbers[-1]]
end

sum = 0
for line in data
    sum += get_numbers(line).to_i
end 

puts sum