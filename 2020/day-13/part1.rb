def process(data)
  t = data[0].to_i
  bus_ids = data[1].chomp.split(',').reject { |x| x == 'x' }.map(&:to_i)

  1.step.each do |offset|
    bus_id = bus_ids.find { |bus_id| (t + offset) % bus_id == 0 }

    break bus_id * offset if bus_id
  end
end

def input
  File.readlines('./input.txt')
end

puts process(input)
