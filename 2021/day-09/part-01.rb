def process(data)
  lows = data.flat_map.with_index do |row, x|
    row.filter.with_index do |r, y|
      adjs = [[x - 1, y], [x + 1, y], [x, y - 1], [x, y + 1]]
      adjs.map { |xy| data.dig(*xy) }.compact.all? { |a| a > r }
    end
  end

  lows.sum + lows.size
end

def input
  File.readlines(ARGV.first).map { |l| l.chomp.chars.map(&:to_i) }
end

puts process(input)
