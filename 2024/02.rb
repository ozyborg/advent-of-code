def input
  File.read('./inputs/02.txt')
end

def data
  input.split("\n").map { |line| line.split(' ').map(&:to_i) }
end

def safe?(report)
  diffs = report.each_cons(2).map { |a, b| a - b }

  diffs.all? { |d| [1, 2, 3].include?(d) } ||  diffs.all? { |d| [-1, -2, -3].include?(d) }
end

def part_1
  data.count { |d| safe?(d) }
end

def part_2
  data.count do |d|
    d.combination(d.size - 1).any? { |comb| safe?(comb) }
  end
end

puts "Part 1: #{part_1}"
puts "Part 2: #{part_2}"