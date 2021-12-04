def process(data)
  row_board_map = data[:boards].flatten(1).map.with_index { |v, i| [v, i / 5] }
  col_board_map = data[:boards].map(&:transpose).flatten(1).map.with_index { |v, i| [v, i / 5] }

  winners = []

  data[:numbers].size.times do |i|
    subset = data[:numbers].first(i + 1)

    winners |= row_board_map.filter { |k, v| (k - subset).empty? }.map(&:last)
    winners |= col_board_map.filter { |k, v| (k - subset).empty? }.map(&:last)

    break (data[:boards][winners.last].flatten - subset).sum * subset.last if winners.size == data[:boards].size
  end
end

def input
  numbers, *boards = File.read(ARGV.first).split("\n\n")

  {
    numbers: numbers.split(',').map(&:to_i),
    boards: boards.map { |b| b.split("\n").map { |l| l.split(' ').map(&:to_i) } }
  }
end

puts process(input)
