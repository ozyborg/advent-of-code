def process(data)
  data.map(&:sum).max
end

def input
  File.read(ARGV.first)
      .split("\n\n")
      .map { |g| g.split("\n").map(&:to_i) }
end

puts process(input)
