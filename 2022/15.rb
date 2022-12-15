def part_2(data)
  y = 4000000

  (0..y).each do |row|
    ranges = []

    data.each do |s_x, s_y, b_x, b_y|
      d = (s_x - b_x).abs + (s_y - b_y).abs
      steps = d - (s_y - row).abs

      next if steps < 0

      ranges << ((s_x - steps).clamp(0, y)..(s_x + steps).clamp(0, y))
    end

    ranges.sort_by!(&:begin)

    r_begin = ranges[0].begin
    r_end = ranges[0].end

    (1..ranges.size - 1).each do |i|
      if ranges[i].begin - r_end > 1
        return (r_end + 1) * 4000000 + row
      else
        r_begin = [r_begin, ranges[i].begin].min
        r_end = [r_end, ranges[i].end].max
      end
    end
  end
end

def part_1(data)
  row = 2000000

  ranges = []

  data.each do |s_x, s_y, b_x, b_y|
    d = (s_x - b_x).abs + (s_y - b_y).abs
    steps = d - (s_y - row).abs

    next if steps < 0

    ranges << ((s_x - steps)..(s_x + steps))
  end

  ranges.map(&:to_a).reduce(:|).size - data.select { |d| d[3] == row }.map { |d| d[2] }.uniq.size
end

def input
  File.read('./inputs/15.txt').split("\n").map { |l| l.scan(/-?\d+/).map(&:to_i) }
end

puts part_1(input)
puts part_2(input)
