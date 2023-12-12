require '../utils/get_input.rb'

data = get_input(9).split("\n")

result = 0
for line in data
    memory = []
    values = line.split(" ").map(&:to_i)

    while values.count(0) != values.length
        new_values = []
        memory << [values]

        (values.length - 1).times do |index|
            new_values << (values[index] - values[index + 1]).abs
        end

        values = new_values
    end

    memory << [values]

    val = 0
    (memory.length - 1).downto(1) do |index|
        val = memory[index - 1][0][-1] + val
    end
    result += val
end

puts result