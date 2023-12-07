require '../utils/get_input.rb'

data = get_input(3).split("\n")

width = data[0].length
height = data.length

data = data.join('')

found_gears = {}
neighbours = []
current_number = ""
0.upto(width * height - 1) do |i|
    char = data[i]

    if i % width == 0 && current_number != ""
        puts "%s %s %s" % [current_number, neighbours.length, neighbours.join(' ')]
        for gear in neighbours
            if !found_gears[gear]
                found_gears[gear] = [current_number.to_i]
            else
                found_gears[gear] << current_number.to_i
            end
        end
        
        current_number = ""
        neighbours = []
    end

    if char.scan(/[0-9]/).length > 0
        current_number += char
        neighbours = i % width != 0 && i - width - 1 >= 0 && data[i - width - 1].scan(/[*]/).length > 0 ? neighbours + [i - width - 1] : neighbours
        neighbours = i - width >= 0 && data[i - width].scan(/[*]/).length > 0 ? neighbours + [i - width] : neighbours
        neighbours = i % width != width - 1 && i - width + 1 >= 0 && data[i - width + 1].scan(/[*]/).length > 0 ? neighbours + [i - width + 1] : neighbours

        neighbours = i % width != 0 && i - 1 >= 0 && data[i - 1].scan(/[*]/).length > 0 ? neighbours + [i - 1] : neighbours
        neighbours = i % width != width - 1 && i + 1 < width * height - 1 && data[i + 1].scan(/[*]/).length > 0 ? neighbours + [i + 1] : neighbours

        neighbours = i % width != 0 && i + width - 1 < width * height - 1 && data[i + width - 1].scan(/[*]/).length > 0 ? neighbours + [i + width - 1] : neighbours
        neighbours = i + width < width * height - 1 && data[i + width].scan(/[*]/).length > 0 ? neighbours + [i + width] : neighbours
        neighbours = i % width != width - 1 && i + width + 1 < width * height - 1 && data[i + width + 1].scan(/[*]/).length > 0 ? neighbours + [i + width + 1] : neighbours

        neighbours = neighbours.uniq
    else
        if current_number != ""
            puts "%s %s %s" % [current_number, neighbours.length, neighbours.join(' ')]
            for gear in neighbours
                if !found_gears[gear]
                    found_gears[gear] = [current_number.to_i]
                else
                    found_gears[gear] << current_number.to_i
                end
            end
            
            current_number = ""
            neighbours = []
        end
    end
end

if current_number != ""
    puts "%s %s %s" % [current_number, neighbours.length, neighbours.join(' ')]
    for gear in neighbours
        if !found_gears[gear]
            found_gears[gear] = [current_number.to_i]
        else
            found_gears[gear] << current_number.to_i
        end
    end
    
end

puts found_gears

sum = 0

for gear, value in found_gears
    if value.length == 2
        sum += value[0] * value[1]
    end
end

puts sum
