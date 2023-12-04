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
    copies = Array.new(data.size, 1)

    data.each_with_index do |d, i|
      (d.first & d.last).size.times { |j| copies[i + j + 1] += copies[i] }
    end

    copies.sum
  end
end

puts Puzzle.new.solve