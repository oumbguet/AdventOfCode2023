require '../utils/get_input.rb'

data = get_input(5).split(/\n\n.+:\n/).map { |line| line.split("\n") }

seeds = data[0][0].split(": ")[1].split(" ").map(&:to_i)

sum = 0

tmp_seeds = []
(0..seeds.length - 1).step(2).each do |i|
    sum += seeds[i] + seeds[i+1] - seeds[i]
    tmp_seeds << (seeds[i]..seeds[i] + seeds[i+1])
end

seed_ranges = tmp_seeds

data = data[1..-1].map { |relation_map| relation_map.map { |line| line.split(" ").map(&:to_i) } }

lowest = 999999999999
seed_ranges.each_with_index do |seed_range, outer_index|
    puts "Total: %d %%" % [outer_index / (seed_ranges.length / 100.0)]
    seed_range.each_with_index do |seed, index|
        if index % (seed_range.size / 100.0 - 1) == 0 || index == seed_range.size - 1
            puts "Current range: %d %%" % [(index + 1) / (seed_range.size / 100.0)]
        end
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
end

puts lowest
