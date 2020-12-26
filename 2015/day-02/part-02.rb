def process(data)
  data.inject(0) do |sum, lwh|
    sum + 2 * lwh.sort.first(2).sum + lwh.reduce(:*)
  end
end

def input
  File.read(ARGV.first)
      .scan(/(\d+)x(\d+)x(\d+)/)
      .map { |line| line.map(&:to_i) }
end

puts process(input)

