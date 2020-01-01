def fuel_req(mass)
  req = (mass / 3) - 2
  return 0 if req <= 0

  req + fuel_req(req)
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
