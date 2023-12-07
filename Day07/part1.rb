require '../utils/get_input.rb'

data = get_input(7).split("\n")

$cards = ["A", "K", "Q", "J", "T", "9", "8", "7", "6", "5", "4", "3", "2"]

class Hand
    attr_reader :value
    attr_reader :hand
    attr_reader :bid

    def initialize(hand, bid)
        @hand = hand
        @bid = bid
        @value = get_hand_ranking(hand)
    end

    def get_hand_ranking(hand)
        hash = Hash.new()
        $cards.each { |c| hash[c] = 0 }
        hand.split("").each { |c| hash[c] += 1 }

        if hash.values.include? 5
            return 7
        elsif hash.values.include? 4
            return 6
        elsif (hash.values.include? 3) && (hash.values.include? 2)
            return 5
        elsif (hash.values.include? 3) && !(hash.values.include? 2)
            return 4
        elsif hash.values.count(2) == 2
            return 3
        elsif hash.values.count(2) == 1 && hash.values.count(1) == 3
            return 2
        elsif hash.values.count(1) == 5
            return 1
        end

        return 0
    end

    def dump()
        puts "%s %d pts, bids %d" % [@hand, @value, @bid]
    end
end

def compare_hand(a, b)
    a = a.hand
    b = b.hand

    0.upto(a.length - 1) do |i|
        if $cards.index(a[i]) < $cards.index(b[i])
            return 1
        elsif $cards.index(a[i]) > $cards.index(b[i])
            return -1
        else
            next
        end
    end

    return 0
end

hands = []
for line in data
    hand, bid = line.split(" ")

    hands << Hand.new(hand, bid)
end

hands = hands.sort { |a, b|
    if a.value == b.value
        compare_hand(a, b)
    else
        a.value - b.value
    end
}

sum = 0
hands.each_with_index do |hand, index|
    sum += (index + 1) * hand.bid.to_i
end

puts sum