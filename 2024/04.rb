def input
  File.read('./inputs/04.txt')
end

def data
  input.split("\n").flat_map.with_index do |line, row|
    line.chars.map.with_index do |ch, col|
      [[row, col], ch]
    end
  end.to_h
end

def part_1
  deltas = [
    [[0, 1], [0, 2], [0, 3]],
    [[0, -1], [0, -2], [0, -3]],
    [[1, 0], [2, 0], [3, 0]],
    [[-1, 0], [-2, 0], [-3, 0]],
    [[1, 1], [2, 2], [3, 3]],
    [[1, -1], [2, -2], [3, -3]],
    [[-1, -1], [-2, -2], [-3, -3]],
    [[-1, 1], [-2, 2], [-3, 3]]
  ]

  data.sum do |k, v|
    next 0 if v != 'X'

    deltas.count do |delta|
      delta.map { |d| data[k.zip(d).map(&:sum)] }.compact == ['M', 'A', 'S']
    end
  end
end

def part_2
  deltas = [
    [[-1, -1], [1, 1]],
    [[1, -1], [-1, 1]]
  ]

  data.count do |k, v|
    next if v != 'A'

    deltas.all? do |delta|
      delta.map { |d| data[k.zip(d).map(&:sum)] }.compact.sort == ['M', 'S']
    end
  end
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"