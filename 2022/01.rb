def part_2(data)
  data.map(&:sum).sort.last(3).sum
end

def part_1(data)
  data.map(&:sum).max
end

def input
  File.read('./inputs/01.txt')
      .split("\n\n")
      .map { |g| g.split("\n").map(&:to_i) }
end

puts part_1(input)
puts part_2(input)
