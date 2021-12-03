def process(data)
  gamma = data.transpose.map { |d| d.tally.max_by(&:last).first }.join.to_i(2)
  epsilon = data.transpose.map { |d| d.tally.min_by(&:last).first }.join.to_i(2)

  gamma * epsilon
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars }
end

puts process(input)
