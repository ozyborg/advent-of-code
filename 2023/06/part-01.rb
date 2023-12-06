class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").map do |line|
      key, *values = line.split

      values.map(&:to_i)
    end
  end

  def solve
    times, distances = data

    (times.zip(distances)).map do |time, distance|
      (time / 2 + 1..).take_while do |t|
        t * (time - t) > distance
      end.count * 2 + (time.even? ? 1 : 0)
    end.reduce(:*)
  end
end

puts Puzzle.new.solve