def process(data)
  points = data.inject([]) do |acc, d|
    x1, y1, x2, y2 = d

    delta = [x2 <=> x1, y2 <=> y1]

    sub_points = [[x1, y1]]

    while(sub_points.last != [x2, y2])
      sub_points << [sub_points.last, delta].transpose.map(&:sum)
    end

    acc + sub_points
  end

  points.tally.count { |k, v| v > 1 }
end

def input
  File.read(ARGV.first)
      .scan(/(\d+),(\d+) -> (\d+),(\d+)\n?/)
      .map { |l| l.map(&:to_i) }
end

puts process(input)
