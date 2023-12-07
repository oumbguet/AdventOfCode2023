require '../utils/get_input.rb'
require 'set'

data = get_input(4).split("\n")

def get_card_value(line)
    value = 0
    _, numbers = line.split(": ")
    winning_numbers, my_numbers = numbers.split(" | ").map {|l| l.split(" ").to_set}

    for winning_number in winning_numbers
        if my_numbers.include? winning_number
            value = value == 0 ? 1 : value * 2
        end
    end

    puts value
    return value
end

sum = 0

for line in data
    sum += get_card_value(line)
end

puts sum
