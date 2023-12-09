require '../utils/get_input.rb'

data = get_input(8).split("\n")

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

current_node = nodes["AAA"]
steps_count = 0

while current_node.name != "ZZZ"
    for direction in directions
        steps_count += 1
        if direction == 'L'
            current_node = nodes[current_node.left]
        else
            current_node = nodes[current_node.right]
        end

        if current_node.name == "ZZZ"
            break
        end
    end
end

current_node.dump
puts steps_count
