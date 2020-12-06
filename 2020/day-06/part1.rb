def process(data)
  data.inject(0) do |sum, d|
    sum + d.split("\n").map(&:chars).reduce(:|).size
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
