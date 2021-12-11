def process(data)
  (0..).each do |i|
    break i if data.values.all?(0)

    data.transform_values!(&:next)

    flashed = {}

    loop do
      flashes = data.filter { |k, v| v > 9 }

      break if flashes.empty?

      flashed.merge!(flashes)

      flashes.each do |k, v|
        data[k] = 0

        x, y = k

        adjs = [
          [x - 1, y - 1], [x - 1, y], [x - 1, y + 1],
          [x, y - 1], [x, y + 1],
          [x + 1, y - 1], [x + 1, y], [x + 1, y + 1]
        ]

        adjs.each do |a|
          data[a] = data[a].next if data.key?(a) && !flashed.key?(a)
        end
      end
    end
  end
end

def input
  File.readlines(ARGV.first)
      .map { |l| l.chomp.chars.map(&:to_i) }
      .map.with_index do |row, x|
        row.map.with_index do |col, y|
          [[x, y], col]
        end
      end.flatten(1).to_h
end

puts process(input)
