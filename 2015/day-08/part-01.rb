def process(data)
  data.inject(0) do |sum, d|
    sum + (d.size - eval(d).size)
  end
end

def input
  File.readlines(ARGV.first).map(&:chomp)
end

puts process(input)

