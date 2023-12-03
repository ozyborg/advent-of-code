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
    gear_parts = {}

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

      adjs = [[x_min, y], [x_max, y]]
      adjs += (x_min..x_max).map { |i| [i, y - 1] }
      adjs += (x_min..x_max).map { |i| [i, y + 1] }

      adjs.each do |adj|
        if data[adj] == '*'
          gear_parts[adj] = [] unless gear_parts.key?(adj)
          gear_parts[adj] << (x_min + 1..x_max - 1).map { |i| data[[i, y]] }.join.to_i

          break
        end
      end
    end

    gear_parts.values.select { |v| v.size == 2 }.sum { |v| v.reduce(:*) }
  end
end

puts Puzzle.new.solve