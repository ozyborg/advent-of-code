def process(data)
  positions = [data[0] - 1, data[1] - 1]
  scores = [0, 0]

  (1..100).cycle.each_slice(3).with_index do |numbers, i|
    positions[i % 2] = (positions[i % 2] + numbers.sum) % 10
    scores[i % 2] += positions[i % 2] + 1
    break scores[(i + 1) % 2] * ((i + 1) * 3) if scores[i % 2] >= 1000
  end
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars.last.to_i }
end

puts process(input)
