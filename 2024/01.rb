def input
  File.read('./inputs/01.txt')
end

def data
  input.split("\n")
    .map { |line| line.split(' ').map(&:to_i) }
    .transpose
end

def part_1
  data.map(&:sort).transpose.sum { |d| (d[0] - d[1]).abs }
end

def part_2
  data[0].sum { |d| d * data[1].count(d) }
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"
