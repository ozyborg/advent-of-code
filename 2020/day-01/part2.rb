def process(data)
  data
    .combination(3)
    .find { |pair| pair.sum == 2020 }
    .reduce(:*)
end

def input
  File.readlines('./input.txt').map(&:to_i)
end

puts process(input)
