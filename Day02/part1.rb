require '../utils/get_input.rb'

data = get_input(2).split("\n")

def get_rgb_count(turn)
    colors = turn.split(", ")
    count = {
        "red" => 0,
        "green" => 0,
        "blue" => 0
    }

    for color in colors
        number, color_name = color.split(' ')
        count[color_name] = number.to_i
    end

    return count
end

def total_count(line)
    turns = line.split(": ")[1].split("; ")
    count = {
        "red" => 0,
        "green" => 0,
        "blue" => 0
    }

    for turn in turns
        turn_count = get_rgb_count(turn)
        for key in count.keys
            count[key] = turn_count[key] if turn_count[key] > count[key]
        end
    end

    return count
end

def is_possible(line)
    index = line.split(' ')[1][0...-1].to_i
    count = total_count(line)

    return count["red"] <= 12 && count["green"] <= 13 && count["blue"] <= 14 ? index : 0
end

sum = 0
for line in data
    sum += is_possible(line)
end

puts sum