def input
  File.read('./inputs/05.txt')
end

def data
  parts = input.split("\n\n")

  [
    parts[0].split("\n").map { |r| r.split("|").map(&:to_i) },
    parts[1].split("\n").map { |r| r.split(",").map(&:to_i) }
  ]
end

def part_1
  rules, updates = data

  updates.select do |numbers|
    numbers.combination(2).all? { |c| rules.include?(c) }
  end.sum { |numbers| numbers[numbers.size / 2] }
end

def part_2
  rules, updates = data

  updates.reject do |numbers|
    numbers.combination(2).all? { |c| rules.include?(c) }
  end.map do |numbers|
     numbers.permutation(2).select { |c| rules.include?(c) }
            .map(&:first).tally.sort_by(&:last).map(&:first).reverse
  end.sum { |numbers| numbers[numbers.size / 2] }
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"
