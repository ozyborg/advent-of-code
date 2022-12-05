def part_2(data)
  crates, instructions = data

  instructions.each do |q, from, to|
    crates[to - 1].unshift(*crates[from - 1].shift(q))
  end

  crates.map(&:first).join
end

def part_1(data)
  crates, instructions = data

  instructions.each do |q, from, to|
    crates[to - 1].unshift(*crates[from - 1].shift(q).reverse)
  end

  crates.map(&:first).join
end

def input
  crates, instructions = File.read('./inputs/05.txt').split("\n\n")

  [
    crates.split("\n").map(&:chars).transpose.map { |l| l.select { |c| c.match?(/[A-Z]/) } }.reject(&:empty?),
    instructions.scan(/move (\d+) from (\d+) to (\d+)\n?/).map { |l| l.map(&:to_i) }
  ]
end

puts part_1(input)
puts part_2(input)
