class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").flat_map.with_index do |l, y|
      l.chars.map.with_index { |v, x| [[x, y], v] }
    end.to_h
  end

  def solve
    data.reject! { |xy, v| v == '.' }

    numbers = data.select { |xy, v| ('0'..'9').include?(v) }.keys
    symbols = data.reject { |xy, v| ('0'..'9').include?(v) }.keys

    number_map = numbers.reduce({}) do |acc, (x, y)|
      acc.merge([x, y] => acc[[x - 1, y]] || [x, y])
    end

    symbol_numbers = symbols.reduce({}) do |acc, xy|
      adjs = [-1, 0, 1].repeated_permutation(2).map { |d| xy.zip(d).map(&:sum) }

      acc.merge(xy => adjs.filter_map { |pos| number_map[pos] }.uniq)
    end

    part_numbers = symbol_numbers.values.flatten(1).uniq

    part_numbers.sum do |xy|
      digit_positions = number_map.select { |k, v| v == xy }.keys
      digit_positions.map { |xy| data[xy] }.join.to_i
    end
  end
end

puts Puzzle.new.solve