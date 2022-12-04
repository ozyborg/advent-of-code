def part_2(data)
  data.count do |d|
    r1 = Range.new(d[0], d[1]).to_a
    r2 = Range.new(d[2], d[3]).to_a

    (r1 & r2).any?
  end
end

def part_1(data)
  data.count do |d|
    r1 = Range.new(d[0], d[1])
    r2 = Range.new(d[2], d[3])

    r1.cover?(r2) || r2.cover?(r1)
  end
end

def input
  File.read('./inputs/04.txt')
      .scan(/(\d+)-(\d+),(\d+)-(\d+)\n?/)
      .map { |l| l.map(&:to_i) }
end

puts part_1(input)
puts part_2(input)
