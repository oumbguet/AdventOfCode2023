require '../utils/get_input.rb'

data = get_input(3).split("\n")

width = data[0].length
height = data.length

data = data.join('')

neighbours = false
current_number = ""
sum = 0
0.upto(width * height - 1) do |i|
    char = data[i]

    if i % width == 0 && current_number != ""
        puts "%s %s" % [current_number, neighbours.to_s]
        sum += neighbours ? current_number.to_i : 0
        current_number = ""
        neighbours = false
    end

    if char.scan(/[0-9]/).length > 0
        current_number += char
        neighbours = i % width != 0 && i - width - 1 >= 0 && data[i - width - 1].scan(/[^0-9\.]/).length > 0 ? true : neighbours
        neighbours = i - width >= 0 && data[i - width].scan(/[^0-9\.]/).length > 0 ? true : neighbours
        neighbours = i % width != width - 1 && i - width + 1 >= 0 && data[i - width + 1].scan(/[^0-9\.]/).length > 0 ? true : neighbours

        neighbours = i % width != 0 && i - 1 >= 0 && data[i - 1].scan(/[^0-9\.]/).length > 0 ? true : neighbours
        neighbours = i % width != width - 1 && i + 1 < width * height - 1 && data[i + 1].scan(/[^0-9\.]/).length > 0 ? true : neighbours

        neighbours = i % width != 0 && i + width - 1 < width * height - 1 && data[i + width - 1].scan(/[^0-9\.]/).length > 0 ? true : neighbours
        neighbours = i + width < width * height - 1 && data[i + width].scan(/[^0-9\.]/).length > 0 ? true : neighbours
        neighbours = i % width != width - 1 && i + width + 1 < width * height - 1 && data[i + width + 1].scan(/[^0-9\.]/).length > 0 ? true : neighbours
    else
        if current_number != ""
            puts "%s %s" % [current_number, neighbours.to_s]
            sum += neighbours ? current_number.to_i : 0
            current_number = ""
            neighbours = false
        end
    end
end

if current_number != ""
    puts "%s %s" % [current_number, neighbours.to_s]
    sum += neighbours ? current_number.to_i : 0
end

puts sum