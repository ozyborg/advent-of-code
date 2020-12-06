def process(data)
  data.inject(0) do |sum, d|
    sum + d.scan(/[a-z]/).uniq.size
  end
end

def input
  File.read('./input.txt').split("\n\n")
end

puts process(input)
