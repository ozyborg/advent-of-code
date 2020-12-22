def play(cards, history = [])
  loop do
    key = cards.map { |c| c.join(',') }.join('|')

    break 0 if history.include?(key)

    history << key

    round = cards.map(&:shift)

    winner = if round[0] <= cards[0].size && round[1] <= cards[1].size
      play(cards.map.with_index { |c, i| c.first(round[i]) }, [])
    else
      round.index(round.max)
    end

    cards[winner].push(round[winner], round[winner - 1])

    break winner if cards[winner - 1].empty?
  end
end

def process(data)
  cards = data.map do |d|
    d.split(":\n")[1].split("\n").map(&:to_i)
  end

  winner = play(cards)
  deck = cards[winner]
  deck.size.downto(1).zip(deck).map { |x, y| x * y }.sum
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
