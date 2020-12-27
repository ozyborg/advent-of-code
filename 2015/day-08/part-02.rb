def process(data)
  data.inject(0) do |sum, d|
    sum + 2 + d.scan(/"|\\/).size
  end
end

def input
  File.readlines(ARGV.first).map(&:chomp)
end

puts process(input)

