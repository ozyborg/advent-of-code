class Puzzle
  def input
    @input ||= File.read('./input.txt')
  end

  def data
    @data ||= input.split("\n").flat_map.with_index do |l, y|
      l.chars.map.with_index { |v, x| [[x, y], v] }
    end.to_h
  end

  def is_digit?(v)
    ('0'..'9').include?(v)
  end

  def solve
    part_numbers = []

    data.each do |xy, v|
      x, y = xy

      next unless is_digit?(v)
      next if is_digit?(data[[x - 1, y]])

      x_min = x - 1
      x_max = x + 1

      (x..).each do |i|
        break unless is_digit?(data[[i, y]])

        x_max = i + 1
      end

      adjs = [data[[x_min, y]], data[[x_max, y]]]
      adjs += (x_min..x_max).map { |i| data[[i, y - 1]] }
      adjs += (x_min..x_max).map { |i| data[[i, y + 1]] }

      next if adjs.compact.all? { |v| v == '.' || is_digit?(v) }

      part_numbers << (x_min + 1..x_max - 1).map { |i| data[[i, y]] }.join.to_i
    end

    part_numbers.sum
  end
end

puts Puzzle.new.solve