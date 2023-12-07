class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").map do |line|
      hand, bid = line.split

      [bid.to_i, type(hand.chars), score(hand.chars)]
    end
  end

  def cards
    @cards ||= %w[2 3 4 5 6 7 8 9 T J Q K A]
  end

  def type(hand)
    counts = hand.tally.values.sort

    counts.max - counts.size
  end

  def score(hand)
    hand.map.with_index { |c, i| cards.index(c) * (13 ** (5 - i)) }.sum
  end

  def solve
    sorted = data.sort_by { |bid, type, score| [type, score] }

    sorted.map.with_index { |d, i| d[0] * (i + 1) }.sum
  end
end

puts Puzzle.new.solve

