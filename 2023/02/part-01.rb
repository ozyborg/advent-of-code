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
    data.each_with_index.reduce(0) do |sum, (d, i)|
      next sum if d.map { |set| set['red'].to_i }.max > 12
      next sum if d.map { |set| set['green'].to_i }.max > 13
      next sum if d.map { |set| set['blue'].to_i }.max > 14

      sum + i + 1
    end
  end
end

puts Puzzle.new.solve