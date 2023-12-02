class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").map do |line|
      line.split(':').last.split(';').map(&:strip).map do |set|
        set.split(', ').map(&:split).map(&:reverse).to_h
      end
    end
  end

  def solve
    data.sum do |d|
      [
        d.map { |set| set['red'].to_i }.max,
        d.map { |set| set['green'].to_i }.max,
        d.map { |set| set['blue'].to_i }.max
      ].reduce(:*)
    end
  end
end

puts Puzzle.new.solve