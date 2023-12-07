require '../utils/get_input.rb'

times, distances = get_input(6).split("\n").map { |x| x.split(":")[1].split(" ").map(&:to_i) }

def get_number_of_ways(time, goal_distance)
    count = 0

    0.upto(time) do |t|
        distance = (time - t) * t
        # puts "Holding %d ms, speed of %d mm/ms, distance of %d mm" % [t, t, distance]
        count += distance > goal_distance ? 1 : 0
    end

    return count
end

total = 1
times.each_with_index do |time, index|
    distance = distances[index]
    number = get_number_of_ways(time, distance)

    total *= number > 0 ? number : 1
end

puts total