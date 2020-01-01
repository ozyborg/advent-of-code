def fuel_req(mass)
  (mass / 3) - 2
end

def process(data)
  data.inject(0) do |sum, i|
    sum + fuel_req(i)
  end
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
