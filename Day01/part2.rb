require '../utils/get_input.rb'

data = get_input(1).split("\n")

def get_numbers(str)
    numbers = str.scan(/[0-9]/).join()
    return "%d%d" % [numbers[0], numbers[-1]]
end

def translate_string(str)
    numbers_hash = {
        "one": 1,
        "two": 2,
        "three": 3,
        "four": 4,
        "five": 5,
        "six": 6,
        "seven": 7,
        "eight": 8,
        "nine": 9
    }
    result = ""
    
    i = 0
    while i < str.length
        for key, value in numbers_hash
            if str[i] == value.to_s
                result += str[i]
                break
            elsif str[i..-1].start_with?(key.to_s)
                result += value.to_s
                break
            end
        end

        i += 1
    end

    return result
end

sum = 0
for line in data
    line = translate_string(line)
    sum += get_numbers(line).to_i
end 

puts sum