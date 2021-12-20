def process(data)
  alg, image = data

  min_x, max_x = image.keys.map(&:first).minmax
  min_y, max_y = image.keys.map(&:last).minmax

  deltas = [
    [-1, -1], [-1, 0], [-1, 1],
    [0, -1], [0, 0], [0, 1],
    [1, -1], [1, 0], [1, 1]
  ]

  2.times do |i|
    min_x, max_x = min_x - 1, max_x + 1
    min_y, max_y = min_y - 1, max_y + 1

    default = alg[0] == 1 ? i % 2 : 0

    image = (min_x..max_x).each.with_object({}) do |x, obj|
      (min_y..max_y).each do |y|
        bin = deltas.map do |d|
          image.fetch([x, y].zip(d).map(&:sum), default)
        end
        obj[[x, y]] = alg[bin.join.to_i(2)]
      end
    end
  end

  image.count { |k, v| v == 1 }
end

def input
  alg, image = File.read(ARGV.first).split("\n\n")
  [
    alg.chars.map { |c| c == '#' ? 1 : 0 },
    image.split("\n").flat_map.with_index do |row, x|
      row.chars.map.with_index do |col, y|
        [[x, y], col == '#' ? 1 : 0]
      end
    end.to_h
  ]
end

puts process(input)
