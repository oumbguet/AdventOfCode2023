require '../utils/get_input.rb'
require 'parallel'

data = get_input(8).split("\r\n")

directions = data[0].split("")
data = data[2..-1]

class Node
    attr_reader :left, :right, :name

    def initialize(line)
        @name = line.split(" = ")[0]
        @left, @right = line.split(" = ")[1][1..-2].split(", ")
    end

    def dump
        puts "%s = (%s, %s)" % [@name, @left, @right]
    end
end

nodes = {}

for line in data
    node_name = line.split(" = ")[0]
    nodes[node_name] = Node.new(line)
end

def check_nodes(nodes)
    all_nodes_at_the_end = true

    for node in nodes
        all_nodes_at_the_end = node.name[2] != "Z" ? false : all_nodes_at_the_end
    end

    return all_nodes_at_the_end
end

current_nodes = nodes.find_all { |key, value| key[2] == "A"}.map { |key, value| value }
steps_count = 0

while !check_nodes(current_nodes)
    for direction in directions
        steps_count += 1
        Parallel.each_with_index(current_nodes) do |node, index|
            if direction == 'L'
                current_nodes[index] = nodes[current_nodes[index].left]
            else
                current_nodes[index] = nodes[current_nodes[index].right]
            end
        end

        if check_nodes(current_nodes)
            break
        end
    end
end

puts "====="
current_nodes.each do |node|
    node.dump
end

puts steps_count
