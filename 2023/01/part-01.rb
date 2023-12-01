class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n")
  end

  def solve
    data.sum { |d| d.scan(/[[:digit:]]/).values_at(0, -1).join.to_i }
  end
end

puts Puzzle.new.solve