require '../utils/get_input.rb'
require 'set'

data = get_input(4).split("\n")

class Card
    attr_reader :index
    attr_reader :winning_numbers
    attr_reader :my_numbers
    attr_accessor :value

    def initialize(line, index)
        @index = index
        _, numbers = line.split(": ")
        @winning_numbers, @my_numbers = numbers.split(" | ").map {|l| l.split(" ").map(&:to_i).to_set}
        @value = 0
    end
end

def get_card_value(card, cards)
    value = 1
    count = 0

    if card.value > 0
        return card.value
    end
    
    for winning_number in card.winning_numbers
        if card.my_numbers.include? winning_number
            count += 1
        end
    end

    if count == 0
        card.value = 1
        return 1
    end

    (card.index + 1).upto(card.index + count) do |i|
        value += get_card_value(cards[i], cards)
    end

    card.value = value

    return value
end

cards = {}
for line in data
    index = line.split(": ")[0].split(" ")[1].to_i

    cards[index] = Card.new(line, index)
end

sum = 0
for index, card in cards
    r = get_card_value(card, cards)
    puts r
    sum += r
end

puts sum
