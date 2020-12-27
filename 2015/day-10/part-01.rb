def process(data)
  40.times do
    data = data.chunk(&:itself).map { |ch| [ch.last.size, ch.first] }.flatten
  end

  data.size
end

def input
  File.read(ARGV.first).chomp.chars.map(&:to_i)
end

puts process(input)

