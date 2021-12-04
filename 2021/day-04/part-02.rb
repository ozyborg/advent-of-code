def process(data)
  row_board_map = data[:boards].flatten(1).map.with_index { |v, i| [v, i / 5] }.to_h
  col_board_map = data[:boards].map(&:transpose).flatten(1).map.with_index { |v, i| [v, i / 5] }.to_h

  winners = []

  data[:numbers].size.times do |i|
    subset = data[:numbers].first(i + 1)

    sub_winners = row_board_map.filter { |k, v| !winners.include?(v) && (k - subset).empty? }.map(&:last)
    sub_winners += col_board_map.filter { |k, v| !winners.include?(v) && (k - subset).empty? }.map(&:last)

    winners += sub_winners.uniq

    break (data[:boards][winners.last].flatten - subset).sum * subset.last if winners.size == data[:boards].size
  end
end

def input
  numbers, *boards = File.read(ARGV.first).split("\n\n")

  {
    numbers: numbers.split(',').map(&:to_i),
    boards: boards.map do |b|
      b.split("\n").map { |l| l.split(' ').map(&:to_i) }
    end
  }
end

puts process(input)
