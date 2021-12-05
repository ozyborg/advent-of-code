def process(data)
  points = []

  data.each do |d|
    x1, y1, x2, y2 = d

    delta = [x2 <=> x1, y2 <=> y1]

    current = [x1, y1]

    loop do
      points << current
      current = [current, delta].transpose.map(&:sum)
      break if current == [x2, y2]
    end

    points << [x2, y2]
  end

  points.tally.count { |k, v| v > 1 }
end

def input
  File.read(ARGV.first)
       .scan(/(\d+),(\d+) -> (\d+),(\d+)\n?/)
       .map { |l| l.map(&:to_i) }
end

p process(input)
