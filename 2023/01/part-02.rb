class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n")
  end

  def solve
    numbers = %w[1 2 3 4 5 6 7 8 9]
    numbers += %w[one two three four five six seven eight nine]

    data.sum do |d|
      ns = numbers.select { |n| d.include?(n) }

      left = ns.min_by { |n| d.index(n) }
      right = ns.max_by { |n| d.rindex(n) }

      [left, right].map { |n| numbers.index(n) % 9 + 1 }.join.to_i
    end
  end
end

puts Puzzle.new.solve