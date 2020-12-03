def count_trees(data, x_step, y_step)
  x_limit = data.first.size
  y_limit = data.size / y_step

  path = (1..y_limit - 1).map do |i|
    data[i * y_step][(i * x_step) % x_limit]
  end

  path.count { |step| step == '#' }
end

def process(data)
  rules = [[1, 1], [3, 1], [5, 1], [7, 1], [1, 2]]

  rules.map { |r| count_trees(data, *r) }.reduce(:*)
end

def input
  File.readlines('./input.txt').map do |line|
    line.chomp.split('')
  end
end

puts process(input)
