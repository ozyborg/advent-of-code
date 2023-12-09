class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").map do |line|
      line.split.map(&:to_i)
    end
  end

  def next_value(seq)
    return 0 if seq.all?(0)

    diffs = seq.each_cons(2).map { |a, b| b - a }

    seq.last + next_value(diffs)
  end

  def solve
    data.sum { |d| next_value(d) }
  end
end

puts Puzzle.new.solve