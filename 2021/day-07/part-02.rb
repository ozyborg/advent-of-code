def process(data)
  (data.min..data.max).map do |d|
    data.sum do |dd|
      x = (d - dd).abs
      x * (x + 1) / 2
    end
  end.min
end

def input
  File.read(ARGV.first).chomp.split(',').map(&:to_i)
end

puts process(input)
