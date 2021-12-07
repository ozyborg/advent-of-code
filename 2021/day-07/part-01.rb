def process(data)
  (data.min..data.max).map { |d| data.sum { |dd| (d - dd).abs } }.min
end

def input
  File.read(ARGV.first).chomp.split(',').map(&:to_i)
end

puts process(input)
