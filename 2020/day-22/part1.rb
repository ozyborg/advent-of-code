def process(data)
  cards = data.map do |d|
    d.split(":\n")[1].split("\n").map(&:to_i)
  end

  until cards.any?(&:empty?)
    round = cards.map(&:shift)

    winner = round.index(round.max)

    cards[winner].push(round[winner], round[winner - 1])
  end

  deck = cards.find(&:any?)
  deck.size.downto(1).zip(deck).map { |x, y| x * y }.sum
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
