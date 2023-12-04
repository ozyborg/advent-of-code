class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").map do |line|
      id, cards = line.split(': ')

      cards.split(' | ').map(&:split)
    end
  end

  def solve
    data.sum do |d|
      next 0 if (d.first & d.last).empty?

      2 ** ((d.first & d.last).size - 1)
    end
  end
end

puts Puzzle.new.solve