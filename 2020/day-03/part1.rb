def process(data)
  x_step = 3
  x_limit = data.first.size
  y_limit = data.size

  path = (1..y_limit - 1).map do |i|
    data[i][(i * x_step) % x_limit]
  end

  path.count { |step| step == '#' }
end

def input
  File.readlines('./input.txt').map do |line|
    line.chomp.split('')
  end
end

puts process(input)
