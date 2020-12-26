def process(data)
  data.inject(0) do |sum, lwh|
    areas = lwh.combination(2)
               .map { |d1, d2| d1 * d2 }

    sum + 2 * areas.sum + areas.min
  end
end

def input
  File.read(ARGV.first)
      .scan(/(\d+)x(\d+)x(\d+)/)
      .map { |line| line.map(&:to_i) }
end

puts process(input)

