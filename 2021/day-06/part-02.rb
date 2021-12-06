def process(data)
  index = [0] * 9

  data.tally.each { |k, v| index[k] = v }

  256.times do
    index.rotate!
    index[6] += index[8]
  end

  index.sum
end

def input
  File.read(ARGV.first).chomp.split(',').map(&:to_i)
end

puts process(input)
