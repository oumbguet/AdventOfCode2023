require '../utils/get_input.rb'

data = get_input(5).split(/\n\n.+:\n/).map { |line| line.split("\n") }

seeds = data[0][0].split(": ")[1].split(" ").map(&:to_i)

data = data[1..-1].map { |relation_map| relation_map.map { |line| line.split(" ").map(&:to_i) } }

lowest = 999999999999
for seed in seeds
    for relation_map in data
        for line in relation_map
            destination, source, range = line

            if source <= seed && seed <= source + range
                seed += destination - source
                break
            end
        end
    end
    if seed < lowest
        lowest = seed
    end
end

puts lowest
